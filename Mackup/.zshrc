source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -v
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias ll="ls -laGh"
alias gs="git status"
alias gc="git commit"
alias v="vim"
alias sl=ls
alias dc=cd
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format

