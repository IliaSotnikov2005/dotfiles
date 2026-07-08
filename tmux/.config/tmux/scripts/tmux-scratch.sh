#!/bin/sh
unset TMUX
exec tmux attach-session -t _popup_scratchpad >/dev/null 2>&1
