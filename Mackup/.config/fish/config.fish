if status is-interactive
    # Commands to run in interactive sessions can go here
    pyenv init - | source
end

fish_vi_key_bindings

alias ll="ls -lhG"
alias la="ls -lahG"
alias gs="git status"
alias gc="git commit -m"
alias ga="git add ."
alias rmi="rm -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias df="df -h"

zoxide init fish | source
zoxide init --cmd cd fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniconda3/bin/conda
    eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

set FZF_DEFAULT_OPTS "--layout=reverse --color=dark --margin=3% --border=rounded"
status --is-interactive; and rbenv init - fish | source
