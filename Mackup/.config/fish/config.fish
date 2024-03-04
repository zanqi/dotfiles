if status is-interactive
    # Commands to run in interactive sessions can go here
    pyenv init - | source
end

fish_vi_key_bindings

alias ll="ls -lhG"
alias la="ls -lahG"
alias gs="git status"
alias gc="git commit"
alias rmi="rm -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias df="df -h"

zoxide init fish | source
zoxide init --cmd cd fish | source
