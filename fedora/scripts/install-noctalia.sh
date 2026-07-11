#!/usr/bin/env bash
set -euo pipefail

echo "=== Installing Noctalia Shell ==="

echo "Noctalia Shell — desktop shell для Wayland (бар, лаунчер, виджеты, обои)."
echo ""

# Check if already installed
if command -v qs &>/dev/null; then
    echo "noctalia-qs (quickshell) is already installed: $(qs --version 2>/dev/null || echo 'unknown version')"
    read -rp "Reinstall? [y/N] " yn
    case "$yn" in
        [Yy]*) ;;
        *) echo "Skipping."; exit 0 ;;
    esac
fi

# noctalia-qs is a custom fork of quickshell, usually from AUR
# On Fedora we try COPR first, then fall back to manual build
echo ""
echo "noctalia-qs is not in official Fedora repos."
echo "Options:"
echo "  1) Build from source (noctalia-qs from AUR)"
echo "  2) Skip"
echo ""
read -rp "Choose [1/2]: " choice

case "$choice" in
    1)
        echo "Building noctalia-qs from source..."

        BUILD_DIR=$(mktemp -d)
        trap 'rm -rf "$BUILD_DIR"' EXIT

        sudo dnf install -y git gcc-c++ cmake qt6-qtbase-devel qt6-qtdeclarative-devel \
            qt6-qtsvg-devel qt6-qtwayland-devel wayland-devel libdrm-devel mesa-libGL-devel \
            pam-devel jemalloc-devel python3

        git clone --depth 1 https://github.com/noctalia-dev/noctalia-qs.git "$BUILD_DIR/noctalia-qs"
        cd "$BUILD_DIR/noctalia-qs"

        cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
        cmake --build build -j"$(nproc)"
        sudo cmake --install build

        echo "noctalia-qs installed successfully."
        ;;
    2)
        echo "Skipping noctalia-qs installation."
        echo "You can install it later from: https://github.com/noctalia-dev/noctalia-qs"
        exit 0
        ;;
    *)
        echo "Invalid choice. Skipping."
        exit 1
        ;;
esac

# Install noctalia-shell
echo ""
echo "Now installing noctalia-shell..."

# noctalia-shell is a QML shell, typically installed from AUR
# Check if it's available via COPR or needs manual install
if rpm -q noctalia-shell &>/dev/null; then
    echo "noctalia-shell is already installed."
else
    echo "noctalia-shell needs to be installed from source or AUR."
    echo "Repository: https://github.com/noctalia-dev/noctalia-shell"
    echo ""
    read -rp "Clone and install noctalia-shell? [y/N] " yn
    case "$yn" in
        [Yy])
            BUILD_DIR2=$(mktemp -d)
            git clone --depth 1 https://github.com/noctalia-dev/noctalia-shell.git "$BUILD_DIR2/noctalia-shell"
            cd "$BUILD_DIR2/noctalia-shell"
            # noctalia-shell is a quickshell-based shell, usually just needs to be placed in the right dir
            sudo mkdir -p /etc/xdg/quickshell/noctalia-shell
            sudo cp -r ./* /etc/xdg/quickshell/noctalia-shell/
            echo "noctalia-shell installed to /etc/xdg/quickshell/noctalia-shell/"
            ;;
        *)
            echo "Skipping noctalia-shell installation."
            ;;
    esac
fi

echo ""
echo "Noctalia setup complete."
echo "Run: qs -c noctalia-shell"
