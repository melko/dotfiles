set -gx SHELL "/usr/bin/fish"
set -gx LESS "-RFXM"
set -gx EDITOR "/usr/bin/vim"

alias cdt="cd (mktemp -d)"

if command -q eza
    alias ll="eza -l --git --icons=auto"
end

if status is-interactive
    if command -q fzf
        if not command -q bat || not command -q fd
            echo "Please install bat and fd to utilize fzf"
        end

        set -gx FZF_DEFAULT_COMMAND 'fd --hidden --no-ignore -E .git'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -gx FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
        fzf --fish | source

        alias fzfbat="fzf --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    end

    if command -q starship
        starship init fish | source
    end

    # add abbreviation where L will be replaced with | less
    abbr -a L --position anywhere "| less"
    # add abbreviation where G will be replaced with | grep
    abbr -a G --position anywhere "| grep"

    # set up/down arrow behaviour zsh-like
    bind down down-or-hsearch
    bind up up-or-hsearch

    # delete a whole word (up to previous space) with ctrl-w
    bind ctrl-w backward-kill-bigword
end
