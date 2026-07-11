#!/usr/bin/env bash
set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz"
FONT_ARCHIVE="JetBrainsMono.tar.xz"

echo "=== Installing JetBrains Mono Nerd Font ==="

mkdir -p "$FONT_DIR"

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Downloading JetBrains Mono Nerd Font..."
curl -fSL "$FONT_URL" -o "$TMP_DIR/$FONT_ARCHIVE"

echo "Extracting..."
tar -xf "$TMP_DIR/$FONT_ARCHIVE" -C "$FONT_DIR"

echo "Updating font cache..."
fc-cache -fv "$FONT_DIR" >/dev/null 2>&1

echo "Verifying..."
if fc-list | grep -qi "JetBrainsMono"; then
    echo "JetBrains Mono Nerd Font installed successfully."
else
    echo "Warning: font may not have installed correctly. Check fc-list."
    exit 1
fi
