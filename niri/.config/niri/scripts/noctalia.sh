#!/bin/sh
# Wrapper: noctalia v5+ uses "noctalia", older uses "qs -c noctalia-shell"
if command -v noctalia >/dev/null 2>&1; then
    exec noctalia "$@"
else
    exec qs -c noctalia-shell "$@"
fi
