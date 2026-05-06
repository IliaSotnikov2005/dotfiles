#!/usr/bin/env fish

set -l session "_popup_scratchpad"

if not tmux has-session -t "$session" 2>/dev/null
    set -l session_id (tmux new-session -dP -s "$session" -F '#{session_id}')

    tmux set-option -s -t "$session_id" key-table popup
    tmux set-option -s -t "$session_id" status off
    tmux set-option -s -t "$session_id" prefix None

    set session "$session_id"
end

exec tmux attach-session -t "$session" >/dev/null
