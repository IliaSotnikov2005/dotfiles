#!/usr/bin/env bash

apps=("nvim" "kitty" "fish" "tmux" "lazygit" "niri" "noctalia" "btop" "yazi" "git")

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

    if [ "$app" = "noctalia" ]; then
        NIRI_STATE="$HOME/.local/state/noctalia"
        if [ -e "$NIRI_STATE/settings.toml" ] && [ ! -L "$NIRI_STATE/settings.toml" ]; then
            echo "Backup existing noctalia state to $NIRI_STATE.bak"
            cp "$NIRI_STATE/settings.toml" "$NIRI_STATE/settings.toml.bak" 2>/dev/null
        fi
        echo "Stow noctalia"
        stow noctalia
        continue
    fi

    TARGET="$HOME/.config/$app"

    if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "Backup existing $app to $TARGET.bak"
        mv "$TARGET" "$TARGET.bak"
    fi

    echo "Stow $app"
    stow "$app"

    if [ "$app" = "niri" ]; then
        NIRI_CFG="$HOME/.config/niri/cfg"
        if [ ! -f "$NIRI_CFG/display.kdl" ]; then
            echo "display.kdl not found, generating default..."
            if command -v wlr-randr &>/dev/null; then
                MON=$(wlr-randr 2>/dev/null | head -1 | tr -d ':')
            fi
            MON="${MON:-eDP-1}"
            cat > "$NIRI_CFG/display.kdl" <<EOF
output "${MON}" {
    mode "1920x1080@60.000"
    scale 1
}
EOF
            echo "Generated $NIRI_CFG/display.kdl — edit it for your monitor."
        fi
    fi
done

echo "Installation complete."
