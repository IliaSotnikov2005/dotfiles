# Neovim Config

> Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) | Theme: [vscode.nvim](https://github.com/Mofiqul/vscode.nvim) | Leader: `Space`

## Structure

```
lua/
├── config/           -- Core: options, keymaps, autocmds, lazy bootstrap
├── plugins/          -- Plugin configs (one file per plugin)
│   └── lang/         -- Per-language: LSP + treesitter + formatter + linter
├── servers/          -- LSP server configs (one file per server)
└── utils/            -- Shared utilities (LSP on_attach, diagnostics)
```

---

## Plugins

### Core

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager with lazy-loading |
| [vscode.nvim](https://github.com/Mofiqul/vscode.nvim) | VS Code dark theme |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Shows keybindings as you type |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File-type icons |
| [alpha-nvim](https://github.com/goolord/alpha.nvim) | Dashboard/start screen |

### Navigation & Search

| Plugin | Description |
|--------|-------------|
| [flash.nvim](https://github.com/folke/flash.nvim) | Jump/motion: `s` jump, `S` treesitter jump |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder for files, grep, symbols, diagnostics |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer tree (width 35, persistent) |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | Search & replace across workspace/file |
| [wildfire.vim](https://github.com/gcmt/wildfire.vim) | Cycle selection through surrounding text objects |

### Editing

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting, folds, text objects, indent |
| [treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Text objects: `af`/`if`/`ac`/`ic`/`ao`/`io` |
| [treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | Sticky function/class header at top of screen |
| [multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim) | Multiple cursors (Sublime-like) |
| [mini.pairs](https://github.com/echasnovski/mini.nvim) | Auto-close brackets/quotes |
| [mini.surround](https://github.com/echasnovski/mini.nvim) | Surround text objects |
| [mini.move](https://github.com/echasnovski/mini.nvim) | Move lines with `<A-j/k>` |
| [mini.comment](https://github.com/echasnovski/mini.nvim) | Commenting with `gc` |
| [treesj](https://github.com/Wansmer/treesj) | Split/join blocks (e.g. multiline args) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODO/FIXME/HACK |

### Completion & LSP

| Plugin | Description |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP quickstart configs |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/tool installer |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine (Codeium, LSP, snippets, buffer, path) |
| [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) | LSP UI: peek definition, code action, rename, hover |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter (stylua, black, prettierd, gofumpt, shfmt, etc.) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linter (luacheck, flake8, eslint_d, shellcheck, etc.) |
| [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | Inline diagnostics display |

### UI

| Plugin | Description |
|--------|-------------|
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tab/buffer line with scope integration |
| [scope.nvim](https://github.com/tiagovla/scope.nvim) | Buffer scoping per tab |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline: mode, branch, diff, filename, LSP, filetype |
| [noice.nvim](https://github.com/folke/noice.nvim) | Improved cmdline, messages, popupmenu UI |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notification UI |
| [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) | Color highlighter (RGB, CSS, Tailwind) |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [zen-mode.nvim](https://github.com/folke/zen-mode.nvim) | Distraction-free coding (60% width) |

### Git

| Plugin | Description |
|--------|-------------|
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git wrapper |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in sign column |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Git diff viewer and file history |

### Terminal & AI

| Plugin | Description |
|--------|-------------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal manager (float/horizontal/vertical/tab) |
| [codeium (windsurf.nvim)](https://github.com/Exafunction/windsurf.nvim) | AI code completion |

### Utilities

| Plugin | Description |
|--------|-------------|
| [auto-session](https://github.com/rmagatti/auto-session) | Session management |
| [auto-save.nvim](https://github.com/okuuva/auto-save.nvim) | Auto-save with debounce |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Vim/tmux split navigation |
| [live-preview.nvim](https://github.com/brianhuster/live-preview.nvim) | Live preview for Markdown/HTML |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Beautiful markdown rendering |
| [nvchad-minty](https://github.com/nvzone/minty) | Color picker (Shades) and palette (Huefy) |
| [mini.bufremove](https://github.com/echasnovski/mini.nvim) | Buffer removal without closing window |
| [mini.trailspace](https://github.com/echasnovski/mini.nvim) | Trim trailing whitespace |
| [mini.indentscope](https://github.com/echasnovski/mini.nvim) | Visual indent scope indicator |
| [mini.cursorword](https://github.com/echasnovski/mini.nvim) | Highlight word under cursor |

### Language configs (`plugins/lang/`)

| File | Languages | Tools |
|------|-----------|-------|
| `go.lua` | Go | gopls, gofumpt, goimports, golines, golangci-lint |
| `python.lua` | Python | pyright, isort, black, flake8 |
| `typescript.lua` | JS/TS/Vue/React | ts_ls, prettierd, eslint_d |
| `lua.lua` | Lua | lua_ls, stylua, luacheck |
| `c.lua` | C/C++ | clangd, clang-format, cpplint |
| `json.lua` | JSON | jsonls, prettierd, fixjson |
| `web.lua` | HTML/CSS/SCSS | emmet_ls, html_lsp, tailwindcss, prettierd |
| `shell.lua` | Bash/Shell | bashls, shfmt, shellcheck |
| `yaml.lua` | YAML | yamlls, prettierd |
| `docker.lua` | Dockerfile | dockerls, hadolint |
| `solidity.lua` | Solidity | solidity_ls_nomicfoundation, prettierd, solhint |

---

## Keybindings

> Leader = `Space`. LSP keymaps are buffer-local (active when LSP attaches).

### General

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>w` | n | Save file |
| `<leader>e` | n | Toggle NvimTree |
| `<leader>rc` | n | Edit config |
| `<leader>z` | n | Toggle Zen Mode |
| `<leader>?` | n | Show buffer-local keymaps |
| `jj` | i | Exit insert mode |
| `<Esc><Esc>` | t | Exit terminal mode |

### Search & Replace

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Browse buffers |
| `<leader>fh` | n | Help tags |
| `<leader>c` | n | Clear search highlights |
| `<leader>ss` | n | Search & Replace (workspace) |
| `<leader>sw` | n/v | Search & Replace word/selection |
| `<leader>sf` | n | Search & Replace in current file |

### Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `s` | n/x/o | Flash jump to any visible position |
| `S` | n/o/x | Flash treesitter jump (select scope) |
| `r` | o | Flash remote (edit inside selected) |
| `<C-h/j/k/l>` | n | Move between windows |
| `<C-up/down/left/right>` | n | Resize windows |
| `<A-j/k>` | n/v | Move line/selection up/down |
| `<S-h/l>` | n | Cycle buffers (left/right) |
| `<leader>bn/bp` | n | Next/previous buffer |
| `n` / `N` | n | Next/prev search result (centered) |
| `<C-d/u>` | n | Half page down/up (centered) |
| `J` | n | Join lines keeping cursor |

### Split & Window

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sv` | n | Split vertically |
| `<leader>sh` | n | Split horizontally |
| `<leader>x` | n | Close buffer (keep window) |

### Treesitter Objects & Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `af` / `if` | o | Around/inside function |
| `ac` / `ic` | o | Around/inside class |
| `ao` / `io` | o | Around/inside loop |
| `a?` / `i?` | o | Around/inside conditional |
| `aa` / `ia` | o | Around/inside parameter |
| `]f` / `[f` | n | Next/prev function start |
| `]c` / `[c` | n | Next/prev class start |
| `]o` / `[o` | n | Next/prev loop start |
| `]a` / `[a` | n | Next/prev parameter start |
| `]F` / `[F` | n | Next/prev function end |
| `]C` / `[C` | n | Next/prev class end |
| `]t` / `[t` | n | Next/prev todo comment |

### LSP

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gd` | n | Peek definition |
| `<leader>gD` | n | Goto definition |
| `<leader>gS` | n | Goto definition in split |
| `K` | n | Hover documentation |
| `<leader>ca` | n | Code actions |
| `<leader>rn` | n | Rename symbol |
| `<leader>oi` | n | Organize imports |
| `<leader>lr` | n | Restart LSP |
| `<leader>D` | n | Line diagnostics (float) |
| `<leader>d` | n | Cursor diagnostics |
| `<leader>pd/nd` | n | Prev/next diagnostic |
| `<leader>fd` | n | LSP Finder (definition + references) |
| `<leader>fr` | n | All references |
| `<leader>ft` | n | Type definition |
| `<leader>fs` | n | Document symbols |
| `<leader>fw` | n | Workspace symbols |
| `<leader>fi` | n | Go to implementation |
| `<leader>lf` | n | Format buffer |
| `<leader>lt` | n | Toggle split/join (treesj) |
| `<leader>lS` | n | Toggle split/join recursive |

### Completion (insert mode)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-j/k>` | i | Next/previous item |
| `<C-b/f>` | i | Scroll docs up/down |
| `<C-Space>` | i | Trigger completion |
| `<C-e>` | i | Abort completion |
| `<CR>` | i | Confirm selection |

### Git & Diff

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>dv` | n | Open diffview |
| `<leader>dV` | n | Close diffview |
| `<leader>df` | n | File history |
| `<leader>dF` | n | Repo history |

### Terminal

| Key | Mode | Description |
|-----|------|-------------|
| `` <C-`> `` | n/i | Toggle float terminal |
| `<leader>tf` | n | Float terminal |
| `<leader>th` | n | Horizontal terminal (bottom) |
| `<leader>tv` | n | Vertical terminal |
| `<leader>tt` | n | Tab terminal |
| `<leader>tg` | n | LazyGit (float) |

### Multicursor

| Key | Mode | Description |
|-----|------|-------------|
| `<up/down>` | n/x | Add cursor above/below |
| `<leader><up/down>` | n/x | Skip cursor above/below |
| `<leader>n/N` | n/x | Match add cursor forward/backward |
| `<leader>s/S` | n/x | Match skip cursor forward/backward |
| `<C-q>` | n/x | Toggle multicursor mode |
| `<left/right>` | n/x | Select prev/next cursor |
| `<Esc>` | n | Clear all cursors |

### Diagnostics & Notifications

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>fx` | n | Diagnostics (current file) |
| `<leader>fX` | n | Diagnostics (workspace) |
| `<leader>xt` | n | Todo list (Trouble) |
| `<leader>nc` | n | Dismiss notifications |

### Color & Path

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cp` | n | Color picker (Shades) |
| `<leader>cg` | n | Generate palette (Huefy) |
| `<leader>pa` | n | Copy full file path to clipboard |
| `<leader>fp` | n | Copy full file path to clipboard |
| `<leader>lp` | n | Live preview (Markdown/HTML) |

### DAP (Debug - Rust only)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>dc` | n | Continue / Start |
| `<leader>do` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>du` | n | Step out |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dr` | n | Open DAP REPL |

---

## LSP Servers

| Server | Languages |
|--------|-----------|
| `lua_ls` | Lua |
| `pyright` | Python |
| `gopls` | Go |
| `jsonls` | JSON/JSONC |
| `ts_ls` | TypeScript/JavaScript/Vue |
| `fishls` | Fish |
| `clangd` | C/C++ |
| `dockerls` | Dockerfile |
| `emmet_ls` | HTML/CSS/React/Vue/Svelte |
| `html_lsp` | HTML |
| `yamlls` | YAML |
| `tailwindcss` | CSS/React/Vue/Svelte |
| `solidity_ls_nomicfoundation` | Solidity |
