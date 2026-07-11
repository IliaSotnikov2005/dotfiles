#!/usr/bin/env bash

apps=("nvim" "kitty" "fish" "tmux" "lazygit" "niri" "noctalia" "git")

echo "Installing..."

for app in "${apps[@]}"; do
    if [ "$app" = "git" ]; then
        TARGET="$HOME/.gitconfig"
        SOURCE="$(dirname "$0")/git/.gitconfig"

        if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
            echo "Backup existing $TARGET to $TARGET.bak"
            mv "$TARGET" "$TARGET.bak"
        fi

        echo "Symlink git config"
        ln -sf "$SOURCE" "$TARGET"
        continue
    fi

    TARGET="$HOME/.config/$app"

    if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "Backup existing $app to $TARGET.bak"
        mv "$TARGET" "$TARGET.bak"
    fi

    echo "Stow $app"
    stow "$app"
done

if [ -d "$HOME/.config/niri.bak/cfg" ]; then
    echo "Returning display.kdl and input.kdl from backup..."
    cp "$HOME/.config/niri.bak/cfg/display.kdl" "$HOME/.config/niri/cfg/" 2>/dev/null
    cp "$HOME/.config/niri.bak/cfg/input.kdl" "$HOME/.config/niri/cfg/" 2>/dev/null
fi

echo "Installation complete."
