# ──────────────────────────────────────────────
# Fish Config — self-contained (no distro deps)
# ──────────────────────────────────────────────

# ─── Greeting ───
function fish_greeting
end

# ─── Environment ───
set -gx PATH ~/.local/bin ~/.cargo/bin $PATH

# Man pages with bat
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Fish history format
function history
    builtin history --show-time='%F %T ' $argv
end

# ─── Aliases: eza ───
if type -q eza
    alias ls='eza -al --color=always --group-directories-first --icons=always'
    alias la='eza -a --color=always --group-directories-first --icons=always'
    alias ll='eza -l --color=always --group-directories-first --icons=always'
    alias lt='eza -aT --color=always --group-directories-first --icons=always'
    alias l.='eza -a | grep -e '^\.''
end

# ─── Navigation ───
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# ─── Utilities ───
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias wget='wget -c'
alias backup='cp $argv[1] $argv[1].bak'

# ─── Git ───
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'
alias gd='git diff'

# ─── Copy helper ───
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# ─── !! and !$ helpers (bang-bang) ───
function __history_previous_command
    switch (commandline -t)
    case "!"
        commandline -t $history[1]; commandline -f repaint
    case "*"
        commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
    case "!"
        commandline -t ""
        commandline -f history-token-search-backward
    case "*"
        commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# ─── PATH additions ───
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# ─── Init tools ───
if status is-interactive
    type -q zoxide; and zoxide init fish | source
    type -q thefuck; and thefuck --alias | source
end
