#!/usr/bin/env fish

# Полный путь к скрипту (status filename может подвести в popup, лучше $HOME/...)
set -g script_path (status filename)

# --- ФУНКЦИИ ГЕНЕРАЦИИ ДЕРЕВА ---

function get_tree
    # Получаем список всех сессий
    tmux list-sessions -F "#{session_name}|#{session_attached}" 2>/dev/null | grep -v '^_popup_' | while read -l sess_line
        set -l s_name (echo $sess_line | cut -d'|' -f1)
        set -l s_attached (echo $sess_line | cut -d'|' -f2)

        # Иконка сессии
        set -l s_icon "󰆟 " # Обычная сессия
        test "$s_attached" -gt 0; and set s_icon "󰄬 " # Активная

        # Печатаем строку сессии [S]
        printf "[S] %s %s\n" "$s_icon" "$s_name"

        # Получаем окна только для этой сессии
        tmux list-windows -t "$s_name" -F "#{window_index}|#{window_name}|#{window_flags}|#{pane_current_path}" | while read -l win_line
            set -l w_idx (echo $win_line | cut -d'|' -f1)
            set -l w_name (echo $win_line | cut -d'|' -f2)
            set -l w_flags (echo $win_line | cut -d'|' -f3)
            set -l w_path (echo $win_line | cut -d'|' -f4)

            # Иконка зума или обычного окна
            set -l w_icon "󱂬"
            string match -q "*z*" -- $w_flags; and set w_icon "󰁌"

            # Сокращаем путь
            set -l short_path (echo $w_path | sed "s|^$HOME|~|" | awk -F'/' '{if(NF>2) print $(NF-1)"/"$NF; else print $NF}')

            # Печатаем строку окна [W] с отступом (дерево)
            printf "[W]   ╰─ %s %s:%s (%s)\n" "$w_icon" "$s_name" "$w_idx" "$w_name"
        end
    end
end

function get_sessions_only
    tmux list-sessions -F "#{session_name}|#{session_attached}" 2>/dev/null | grep -v '^_popup_' | while read -l line
        set -l name (echo $line | cut -d'|' -f1)
        set -l attached (echo $line | cut -d'|' -f2)
        set -l icon "󰆟 "
        test "$attached" -gt 0; and set icon "󰄬 "
        printf "[S] %s %s\n" "$icon" "$name"
    end
end

# --- ОБРАБОТКА АРГУМЕНТОВ ---
set -l initial_mode "--get-tree"
set -l prompt "Tree View> "

if set -q argv[1]
    switch $argv[1]
        case "--get-tree"
            get_tree
            exit 0
        case "--get-sessions"
            get_sessions_only
            exit 0
        case "-s" "--sessions"
            set initial_mode "--get-sessions"
            set prompt "Sessions> "
        case "-w" "--windows"
            set initial_mode "--get-tree"
            set prompt "Tree View> "
    end
end

# --- ЗАПУСК FZF ---
set -l selected (fish -c "$script_path $initial_mode" | fzf \
    --reverse --header-first --height=100% --border=none --cycle \
    --prompt="$prompt" \
    --bind="tab:down" \
    --bind="ctrl-w:change-prompt(Tree View> )+reload($script_path --get-tree)" \
    --bind="ctrl-s:change-prompt(Sessions> )+reload($script_path --get-sessions)" \
    --bind="ctrl-x:execute(
        set -l item (echo {} | string collect)
        if string match -q \"*[S]*\" \$item
            set -l target (echo \$item | awk '{print \$NF}')
            tmux kill-session -t \"\$target\"
        else
            set -l target (echo \$item | awk '{print \$4}')
            tmux kill-window -t \"\$target\"
        end
    )+reload(echo {fzf_prompt} | grep -q 'Tree' && $script_path --get-tree || $script_path --get-sessions)"
)

# --- ОБРАБОТКА ВЫБОРА ---
if test -n "$selected"
    if string match -q "*[S]*" "$selected"
        # Извлекаем последнее слово (имя сессии)
        set -l sess_name (echo $selected | awk '{print $NF}')
        if set -q TMUX
            tmux switch-client -t "$sess_name"
        else
            tmux attach-session -t "$sess_name"
        end
    else
        # Извлекаем 4-й аргумент (session:index)
        set -l win_target (echo $selected | awk '{print $4}')
        set -l sess_name (echo $win_target | cut -d: -f1)
        if set -q TMUX
            tmux select-window -t "$win_target"
            tmux switch-client -t "$sess_name"
        else
            tmux attach-session -t "$sess_name" \; select-window -t "$win_target"
        end
    end
end
