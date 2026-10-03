# Neovim Keybindings

> Полный список биндов. Core / LSP / Plugins.

Leader = `Space`

## Core (lua/config/keymaps.lua)

| Key | Mode | Description |
|---|------|-------------|
| `<` | `v` | Indent left and reselect |
| `<A-j>` | `n` | Move line down |
| `<A-j>` | `v` | Move selection down |
| `<A-k>` | `n` | Move line up |
| `<A-k>` | `v` | Move selection up |
| `<C-Down>` | `n` | Decrease window height |
| `<C-Left>` | `n` | Decrease window width |
| `<C-Right>` | `n` | Increase window width |
| `<C-Up>` | `n` | Increase window height |
| `<C-c>p` | `i` | ColorPicker |
| `<C-d>` | `n` | Half page down (centered) |
| `<C-h>` | `n` | Move to left window |
| `<C-j>` | `n` | Move to bottom window |
| `<C-k>` | `n` | Move to top window |
| `<C-l>` | `n` | Move to right window |
| `<C-u>` | `n` | Half page up (centered) |
| `<S-h>` | `n` | Prev Buffer |
| `<S-l>` | `n` | Next Buffer |
| `<leader>bn` | `n` | Next buffer |
| `<leader>bp` | `n` | Previous buffer |
| `<leader>c` | `n` | Clear search highlights |
| `<leader>cg` | `n` | Generate palette |
| `<leader>cp` | `n` | ColorPicker |
| `<leader>rc` | `n` | Edit config |
| `<leader>sh` | `n` | Split window horizontally |
| `<leader>sv` | `n` | Split window vertically |
| `<leader>w` | `n` | Save file |
| `<leader>x` | `v` | Delete without yanking |
| `>` | `v` | Indent right and reselect |
| `J` | `n` | Join lines and keep cursor position |
| `N` | `n` | Previous search result (centered) |
| `c` | `n` | Change (black hole) |
| `cc` | `n` | Change line (black hole) |
| `d` | `n` | Delete (black hole) |
| `d` | `x` | Delete selection (black hole) |
| `dd` | `n` | Delete line (black hole) |
| `jj` | `i` | Exit insert mode with jj |
| `n` | `n` | Next search result (centered) |
| `p` | `x` | Paste without yanking |
| `x` | `n` | Delete char (black hole) |

## Plugins (by plugin)

| Key | Mode | Description |
|---|------|-------------|
### diffview

| Key | Mode | Description |
|---|------|-------------|
| `<leader>dF` | `n` | Repo history |
| `<leader>dV` | `n` | Close diffview |
| `<leader>df` | `n` | File history |
| `<leader>dm` | `n` | Merge tool |
| `<leader>dv` | `n` | Open diffview |

### flash

| Key | Mode | Description |
|---|------|-------------|
| `r` | `o` | Flash Remote |

### fzf-lua

| Key | Mode | Description |
|---|------|-------------|
| `<leader>fS` | `n` | FZF Workspace Symbols |
| `<leader>fX` | `n` | FZF Diagnostics Workspace |
| `<leader>fb` | `n` | FZF Buffers |
| `<leader>ff` | `n` | FZF Files |
| `<leader>fg` | `n` | FZF Live Grep |
| `<leader>fh` | `n` | FZF Help Tags |
| `<leader>fs` | `n` | FZF Document Symbols |
| `<leader>fx` | `n` | FZF Diagnostics Document |

### grug-far

| Key | Mode | Description |
|---|------|-------------|
| `<leader>ss` | `n` | Search & Replace (workspace) |

### live-server

| Key | Mode | Description |
|---|------|-------------|
| `<leader>lp` | `n` | Preview Markdown/HTML |

### multicursor

| Key | Mode | Description |
|---|------|-------------|
| `<c-q>` | `n,x` | Toggle multicursor mode |
| `<down>` | `n,x` | Add cursor below |
| `<leader><down>` | `n,x` | Skip cursor below |
| `<leader><up>` | `n,x` | Skip cursor above |
| `<leader>N` | `n,x` | Match add cursor backward |
| `<leader>S` | `n,x` | Match skip cursor backward |
| `<leader>n` | `n,x` | Match add cursor forward |
| `<leader>s` | `n,x` | Match skip cursor forward |
| `<leader>x` | `n,x` | Delete cursor(s) |
| `<left>` | `n,x` | Select prev cursor |
| `<right>` | `n,x` | Select next cursor |
| `<up>` | `n,x` | Add cursor above |

### todo-comments

| Key | Mode | Description |
|---|------|-------------|
| `<leader>xt` | `n` | Todo (Trouble) |
| `[t` | `n` | Previous todo comment |
| `]t` | `n` | Next todo comment |

### toggleterm

| Key | Mode | Description |
|---|------|-------------|
| `<C-`>` | `n` | Toggle terminal (float) |
| `<Esc><Esc>` | `n` | Exit terminal mode |
| `<leader>tf` | `n` | Float terminal |
| `<leader>th` | `n` | Horizontal terminal |
| `<leader>tt` | `n` | Tab terminal |
| `<leader>tv` | `n` | Vertical terminal |

### treesj

| Key | Mode | Description |
|---|------|-------------|
| `<leader>lt` | `n` | Toggle split/join |

### zen-mode

| Key | Mode | Description |
|---|------|-------------|
| `<leader>z` | `n` | Toggle Zen Mode |

