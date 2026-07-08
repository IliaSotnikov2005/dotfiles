#!/usr/bin/env fish

set -l session "_popup_scratchpad"

if not tmux has-session -t "$session" 2>/dev/null
    tmux new-session -d -s "$session"
end

tmux set-option -t "$session" key-table popup
tmux set-option -t "$session" status off
tmux set-option -t "$session" prefix None

set -e TMUX
exec tmux attach-session -t "$session" >/dev/null
