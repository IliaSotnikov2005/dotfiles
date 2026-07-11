# Base

Минимальный набор пакетов для комфортной работы.

## Установка

```bash
./setup.sh
```

Скрипт интерактивно спросит, что ставить, а что нет.

## Пакеты

| Пакет                       | Описание                                                                          |
| --------------------------- | --------------------------------------------------------------------------------- |
| **ttf-jetbrains-mono-nerd** | Шрифт JetBrains Mono с иконками Nerd Font (нужен для kitty, tmux, nvim, noctalia) |
| **niri**                    | Scrollable-tiling Wayland-композитор                                              |
| **noctalia-shell**          | Минималистичный desktop shell для Wayland (бар, лаунчер, виджеты, обои)           |
| **kitty**                   | GPU-ускоренный терминал                                                           |
| **fish**                    | PowerShell-подобная оболочка с автодополнениями                                   |
| **tmux**                    | Мультиплексор терминала                                                           |
| **nvim**                    | Neovim — модальный текстовый редактор                                             |
| **lazygit**                 | TUI для git                                                                       |
| **eza**                     | Современная замена ls (цвета, иконки, дерево)                                     |
| **bat**                     | cat с подсветкой синтаксиса                                                       |
| **fzf**                     | Fuzzy-finder (поиск файлов, history, процессов)                                   |
| **ripgrep**                 | Быстрый grep (используется в nvim для поиска)                                     |
| **fd**                      | Быстрый find (используется в nvim и fzf)                                          |
| **zoxide**                  | Умный cd (запоминает частые директории)                                           |
| **cliphist**                | История буфера обмена (wl-paste + clipboard history)                              |
| **wl-clipboard**            | Копирование/вставка в Wayland (wl-copy, wl-paste)                                 |
| **grim + slurp**            | Скриншоты в Wayland                                                               |
| **brightnessctl**           | Управление яркостью экрана                                                        |
| **wlr-randr**               | Управление мониторами в wlroots                                                   |

## Дополнительные зависимости

Для работы noctalia-shell также потребуются:

- `quickshell` — QtQuick-based shell toolkit (ноctalia-qs — его форк)
- `imagemagick` — обработка изображений
- `ffmpeg` — аудио/видео (для визуализатора)
- `qt6-multimedia` — мультимедиа виджеты
- `python` — скрипты noctalia
- `wlr-randr` — управление мониторами
