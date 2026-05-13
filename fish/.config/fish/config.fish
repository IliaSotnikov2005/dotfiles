if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

set -g PATH $PATH (go env GOPATH)/bin

function fish_greeting
    # nothing
end

if status is-interactive
    type -q zoxide; and zoxide init fish | source
end
