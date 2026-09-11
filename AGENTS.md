# AGENTS.md — Dotfiles

Репозиторий dotfiles для Linux (Arch/CachyOS, ветка `fedora` — для Fedora). Деплой через **GNU Stow**.

## Общие правила

- Отвечай кратко по делу.
- Перед правкой конфигов смотри, как устроены соседние файлы (стиль, отступы), и повторяй его.
- Не добавляй комментарии в код/конфиги, если их не просили.
- Не коммить без явной просьбы.
- После правок валидируй изменённый файл (раздел «Проверка после правок»).
- Не клади в репозиторий машино-специфичные файлы — добавляй их в `.gitignore`.
- README в этом репо на русском — новые доки/описания тоже пиши на русском.

## Деплой и структура

Репо — набор каталогов по приложению (`<app>/…`), внутри которых воспроизведена структура домашней директории или `~/.config`. Разворачивается скриптом `install.sh`:

| Путь в репо | Куда ставится | Механизм |
|---|---|---|
| `nvim/.config/nvim` | `~/.config/nvim` | stow |
| `kitty/.config/kitty` | `~/.config/kitty` | stow |
| `fish/.config/fish` | `~/.config/fish` | stow |
| `tmux/.config/tmux` | `~/.config/tmux` | stow |
| `lazygit/.config/lazygit` | `~/.config/lazygit` | stow |
| `niri/.config/niri` | `~/.config/niri` | stow (+ генерация `cfg/display.kdl`) |
| `noctalia/.local/state/noctalia` | `~/.local/state/noctalia` | stow (особый случай) |
| `btop/.config/btop` | `~/.config/btop` | stow |
| `yazi/.config/yazi` | `~/.config/yazi` | stow |
| `git/.gitconfig` | `~/.gitconfig` | symlink (не stow) |

### `install.sh`

- Список приложений — массив `apps` в `install.sh:3`. **При добавлении нового приложения нужно обновить и каталог, и этот массив** (порядок: nvim kitty fish tmux lazygit niri noctalia btop yazi git).
- Идемпотентен: существующие **symlink** не трогает и не бэкапит, перебэкапливает только реальные файлы/каталоги в `.bak`.
- Особые случаи:
  - `git` — симлинк `~/.gitconfig` вручную (`ln -sf`), реальный файл бэкапится в `.bak`.
  - `noctalia` — stow в `~/.local/state/noctalia`, при этом ставится поверх state-файла (бэкап `settings.toml.bak`).
  - `niri` — если нет `~/.config/niri/cfg/display.kdl`, генерирует его через `wlr-randr` (fallback `eDP-1`, 1920x1080@60, scale 1). **Не создавай `display.kdl` в репо.** — см. gitignore.

### Добавление нового приложения

1. Создай каталог `<app>/` с внутренней структурой `~/.config/<app>` (или home). Пример: `foo/.config/foo/foo.conf`.
2. Добавь `<app>` в массив `apps` в `install.sh`.
3. `./install.sh` → проверить, что появятся symlink и ничего не переехало.
4. Если у приложения есть state/кэш/секреты под `~/.config/<app>` — добавь соответствующие пути в `.gitignore`, оставляй в треке только нужные конфиги.

### Gitignore и машино-специфичные файлы

См. `.gitignore`. Текущие правила:
- `**/display.kdl` — машино-специфичный мониторный конфиг niri, в репо не кладём.
- `**/lazy-lock.json` — в gitignore, **но nvim-шный lazy-lock.json всё равно закоммичен** (`-f`). При изменении плагинов nvim обновляй и коммить его.
- noctalia v5: в треке только `settings.toml`; clipboard/palettes/templates/plugins/notification/recently_used/usage_counts/.setup-complete — gitignored.

## Правила по приложениям

### nvim (самый часто редактируемый)

- **Точка входа:** `nvim/.config/nvim/init.lua` → `require("config.lazy")`.
- Плагин-менеджер lazy.nvim, лидер `Space`, тема vscode.nvim.
- Структура `lua/`:
  - `config/` — `init.lua`, `options.lua`, `keymaps.lua`, `autocmds.lua`, `globals.lua`, `lazy.lua` (bootstrap, импорт плагинов).
  - `plugins/` — **один файл = один плагин** (`alpha.lua`, `nvim-cmp.lua`, `nvim-lspconfig.lua`, …). Новый плагин — новый файл тут.
  - `plugins/lang/` — по-языковая настройка: LSP + treesitter + format + lint вместе (`c.lua`, `python.lua`, `go.lua`, `web.lua`, …).
  - `servers/` — один файл = один LSP-сервер (`clangd.lua`, `lua_ls.lua`, `pyright.lua`, …); `init.lua` собирает их.
  - `utils/` — общий `lsp.lua` (on_attach + keymaps, включая DAP для rust-analyzer) и `diagnostics.lua`.
- При добавлении языка: `lua/plugins/lang/<lang>.lua` (+ при необходимости сервер в `lua/servers/`).
- После изменения плагинов обнови `lazy-lock.json`, если lazy его менял.
- Полная документирование keymap/плагинов — в `nvim/.config/nvim/README.md` (312 строк, читать там, не в AGENTS.md).

### niri

- `niri/.config/niri/config.kdl` — только `include`-строки на `./cfg/*.kdl`.
- Модули в `cfg/`: `keybinds.kdl`, `layout.kdl`, `display.kdl` (**gitignored, машино-специфичный**), `input.kdl` (en/ru раскладки, caps↔esc, alt_shift toggle), `animation.kdl`, `rules.kdl`, `misc.kdl`, `autostart.kdl` (запуск `noctalia --daemon`).
- Изменения `cfg/*.kdl` niri подхватывает хот-релоадом (сохрани файл — конфиг перезагрузится). Валидация: `niri validate`.
- Скрипты: `scripts/silentScreenShot.sh` (grim+slurp→wl-copy, Mod+S), `scripts/consume-left.sh` (Mod+Shift+C).

### fish

- `fish/.config/fish/config.fish` — главное: PATH (`~/.local/bin`, `~/.cargo/bin`), `EDITOR=nvim`, bat-манягер, алиасы eza (`ls/la/ll/lt`), навигация `..`-`......`, git-алиасы (`g/gs/ga/gc/gp/gl/gd`), функция `copy`, история `!`/`!$`, zoxide/thefuck.
- `conf.d/aliases.fish` — `vim='nvim'`; `conf.d/paths.fish` — `~/.opencode/bin`, `~/.npm-packages/bin`.
- Новые алиасы/функции — в `config.fish` или отдельный файл в `conf.d/` / `functions/`.

### tmux

- `tmux/.config/tmux/tmux.conf`: префикс `C-a`, base-index 1, mouse, vi copy-mode, 50k scrollback, статус сверху, TPM-плагины (sensible, vim-tmux-navigator, resurrect, continuum, yank), автосейв/рестор.
- `theme.conf` — тема Nightfox (подключается из tmux.conf).
- `scripts/` — fzf-меню сессий (`tmux-menu.fish`), scratchpad (`tmux-scratch.{fish,sh}`, биндинг `C-t`).
- «fix tmux» — частый тип коммита. После правки: `tmux source-file ~/.config/tmux/tmux.conf`.

### git

- `git/.gitconfig`: pager delta (side-by-side), editor nvim, merge `zdiff3`, дефолтная ветка `main`, `include` `~/.gitconfig.local` (машино-специфичный — в репо не кладём), credential cache 24h.
- Имя/почта держатся в локальном `~/.gitconfig.local`, в репо их нет. Неисправимо не коммить секреты.

### noctalia

- `noctalia/.local/state/noctalia/settings.toml` — state запущенного desktop shell (бар, control center, локация, тема, палитра, wallpaper dir `~/Pictures/Wallpapers`).
- Обновляется самой noctalia при изменении настроек в UI. Если пользователь попросил «почини бар/палитру/обои» — редактировать этот файл.
- Прочие state-файлы (clipboard, plugins, notifications …) gitignored.

### Китty / lazygit / btop / yazi

- `kitty/.config/kitty/kitty.conf` — шрифт JetBrainsMono Nerd, size 10, opacity 70%, beam cursor, copy-on-select.
- `lazygit/.config/lazygit/config.yml` — nvim как editor (`+{{line}}`), delta-диф.
- `btop/.config/btop/btop.conf` — `vim_keys = true`.
- `yazi/.config/yazi/` — `yazi.toml` (текст+md через `$EDITOR`), `init.lua` (плагины git + full-border).

### base / fedora

- `base/README.md` — список пакетов для Arch/CachyOS (niri, noctalia, kitty, fish, tmux, nvim, lazygit, eza, bat, fzf, ripgrep, fd, zoxide, yazi, btop, cliphist, wl-clipboard, grim+slurp, brightnessctl, wlr-randr, JetBrains Mono Nerd). Ссылается на несуществующий `./setup.sh` (устаревшая ссылка — фактический скрипт в `fedora/setup.sh`; на Arch ставится всё одним пакет-менеджером).
- `fedora/setup.sh` — интерактивный dnf-инсталлер (в ветке `fedora`).
- Если добавляешь пакет в окружение — обнови `base/README.md`.

## Git-конвенции

- Ветки: `main` (текущая, Arch/CachyOS) и `fedora`. Меняя Fedora-специфику — работай на ветке `fedora` и мёржи в `main` при необходимости.
- Ремоты:
  - `origin` = `git@github.com:IliaSotnikov2005/dotfiles.git`
  - `nvim-config` = `https://github.com/IliaSotnikov2005/nvim-config.git` — nvim-дерево публикуется отдельно; `nvim/` отслеживает его `main`. Не рви связь: при правках nvim синхронизируй и с `nvim-config` (push в оба / upstreaме).
- Стиль коммитов (из истории): короткие lowercase-сообщения, префиксы `feat:`, `ref:`/`ref:`, `fix:`, без лишней пунктуации. Примеры: `feat: add diffview merge resolver`, `fix tmux`.
- Не коммить: машино-специфичные `.kdl` дисплеи, секреты, state noctalia кроме `settings.toml`.

## Проверка после правок

Какие команды валидируют, что конфиг корректен:

- **fish:** `fish -n ~/.config/fish/config.fish` (и остальные `.fish`).
- **tmux:** `tmux source-file ~/.config/tmux/tmux.conf`.
- **niri:** `niri validate` (проверка всех `cfg/*.kdl`).
- **gitconfig:** после редеплоя `git config --global --list` (не должно быть опечаток).
- **nvim:** новых плагинов — `nvim --headless "+Lazy! sync" +qa`, обновить `lazy-lock.json`; не «сломан» ли `init.lua` — запустить `nvim -V1` без ошибок.
- **Деплой целиком:** `./install.sh` — проверить, что symlink на месте (`ls -la ~/.config/nvim ~/.gitconfig`), ничего не переехало в `.bak` с прошлой строки.

## Быстрые ссылки (часто правим)

| Что хочется поменять | Файл |
|---|---|
| Хоткеи в редакторе | `nvim/.config/nvim/lua/config/keymaps.lua` |
| Плагин/фича в nvim | `nvim/.config/nvim/lua/plugins/<name>.lua` |
| Новый язык в nvim | `nvim/.config/nvim/lua/plugins/lang/<lang>.lua` (+ `lua/servers/`) |
| Хоткеи/жесты воркспейса | `niri/.config/niri/cfg/keybinds.kdl` (+ `layout.kdl`, `rules.kdl`) |
| Автозапуск | `niri/.config/niri/cfg/autostart.kdl` |
| Монитор/разрешение (машина!) | `~/.config/niri/cfg/display.kdl` (**не в репо**) |
| Алиасы/PATH в шелле | `fish/.config/fish/config.fish`, `conf.d/*` |
| Биндинги/плагины tmux | `tmux/.config/tmux/tmux.conf`, `theme.conf` |
| Pager/merge/editor git | `git/.gitconfig` |
| Бар/палитра/обои noctalia | `noctalia/.local/state/noctalia/settings.toml` |
| Терминал kitty | `kitty/.config/kitty/kitty.conf` |