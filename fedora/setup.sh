#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

PACKAGES=()

ask() {
    local name="$1"
    local desc="$2"
    local extra="${3:-}"

    echo ""
    echo -e "${CYAN}[$name]${NC} $desc"
    if [ -n "$extra" ]; then
        echo "  $extra"
    fi
    read -rp "  Install? [Y/n] " yn
    case "$yn" in
        [Nn]*) echo "  Skipped." ;;
        *) PACKAGES+=("$name"); echo "  Queued." ;;
    esac
}

echo "========================================="
echo "  Fedora Setup — Interactive Installer"
echo "========================================="
echo ""
echo "This script will install packages for your environment."
echo "You can skip anything you don't need."
echo ""

# ─── Core ───
ask "stow" "GNU Stow — symlink manager for dotfiles" "Required to install dotfiles from this repo."

# ─── Shell ───
ask "fish" "Friendly interactive shell" "Default shell with autocompletions, syntax highlighting, sane defaults."

ask "eza" "Modern replacement for ls" "Colors, icons, tree view, git status."

ask "bat" "Cat replacement with syntax highlighting" "Used in fish for man pages (MANPAGER)."

ask "fzf" "Fuzzy finder" "Used in tmux-menu, nvim (fzf-lua), and command history."

ask "zoxide" "Smart cd — remembers your directories" "Typing 'z project' jumps to ~/Projects."

# ─── Niri + Noctalia ───
ask "niri" "Scrollable-tiling Wayland compositor" "Tiling WM, similar to sway but scrollable."

ask "noctalia" "Desktop shell for Wayland (bar, launcher, widgets, wallpaper)" "Requires niri. Built on quickshell (noctalia-qs)."

# ─── Terminal + Editor ───
ask "kitty" "GPU-accelerated terminal emulator" "Fast, extensible, supports ligatures and images."

ask "nvim" "Neovim — modal text editor" "Full IDE setup with LSP, completion, treesitter."

ask "tmux" "Terminal multiplexer" "Panes, sessions, persistent workflow."

ask "lazygit" "TUI for git" "Visual git interface in terminal."

# ─── Fonts ───
ask "nerd-fonts" "JetBrains Mono Nerd Font" "Required by kitty, tmux, nvim, noctalia for icons."

echo ""
echo "========================================="
echo "  Summary"
echo "========================================="
echo ""
echo "Will install: ${PACKAGES[*]}"
echo ""

# ─── Install ───
install_with_dnf() {
    local pkgs=("$@")
    local dnf_pkgs=()

    for pkg in "${pkgs[@]}"; do
        case "$pkg" in
            grim+slurp) dnf_pkgs+=(grim slurp) ;;
            nerd-fonts) ;; # handled separately
            noctalia)   ;; # handled separately
            lazygit)    ;; # handled separately (needs COPR)
            *)          dnf_pkgs+=("$pkg") ;;
        esac
    done

    if [ ${#dnf_pkgs[@]} -gt 0 ]; then
        echo ""
        echo "Installing via dnf: ${dnf_pkgs[*]}"
        sudo dnf install -y "${dnf_pkgs[@]}"
    fi
}

if [ ${#PACKAGES[@]} -eq 0 ]; then
    echo "Nothing to install. Exiting."
    exit 0
fi

read -rp "Proceed with installation? [Y/n] " yn
case "$yn" in
    [Nn]*) echo "Aborted."; exit 0 ;;
esac

# Group 1: dnf packages
install_with_dnf "${PACKAGES[@]}"

# Group 2: Lazygit (COPR)
for pkg in "${PACKAGES[@]}"; do
    if [ "$pkg" = "lazygit" ]; then
        echo ""
        echo "Installing lazygit from COPR..."
        sudo dnf copr enable atim/lazygit -y
        sudo dnf install -y lazygit
    fi
done

# Group 3: Nerd Fonts
for pkg in "${PACKAGES[@]}"; do
    if [ "$pkg" = "nerd-fonts" ]; then
        bash "$SCRIPT_DIR/scripts/install-fonts.sh"
    fi
done

# Group 4: Noctalia
for pkg in "${PACKAGES[@]}"; do
    if [ "$pkg" = "noctalia" ]; then
        bash "$SCRIPT_DIR/scripts/install-noctalia.sh"
    fi
done

echo ""
echo "========================================="
echo "  Installation complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Run 'install.sh' from dotfiles repo to symlink configs"
echo "  2. Set fish as default shell: chsh -s /usr/bin/fish"
echo "  3. Logout and login again"
