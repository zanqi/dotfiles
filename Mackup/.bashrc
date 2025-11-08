export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BYELLOW='\[\e[1;33m\]'
BLUE='\[\e[0;34m\]'
CYAN='\[\e[0;36m\]'
GRAY='\[\e[0;90m\]'
BOLD='\[\e[1m\]'
DIM='\[\e[2m\]'
RESET='\[\e[0m\]'


function timer_start {
  timer=${timer:-$SECONDS}
}

trap 'timer_start' DEBUG

function smile {
    local last_exit=$?
    
    # Run history commands after capturing exit status
    history -a
    history -c
    history -r

    if [ "$last_exit" -eq "0" ]
    then
        SC="${GREEN}"
        status="${SC}✓"
    else
        SC="${RED}"
        status="${SC}✗"
    fi

    elaps=$(($SECONDS - $timer))
    # Only show time for commands that took >3 seconds
    if [ $elaps -gt 3 ]; then
        time_display=" ${SC}${elaps}s${RESET}"
    else
        time_display=""
    fi

    unset timer
    PS1="\n${CYAN}\u@${BYELLOW}\h${RESET} ${BLUE}\w${YELLOW}\$(parse_git_branch)${RESET} ${status}${time_display}${RESET}\n${GRAY}$ ${RESET}"
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
alias ll='ls -lhF --color=auto'
alias ls='ls -G'

bind 'set completion-ignore-case on'

alias attu='ssh attu.cs.washington.edu'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd1='cd -'

alias gs='git status'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias ga='git add --all'
alias gc='git commit -v'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias gst='git stash'

alias cat='bat'
# todo: install fd
# alias find='fd'
alias grep='rg'

mkcd() {
    mkdir -p "$1" && cd "$1"
}

set -o vi

# Append to history file immediately, otherwise, new sessions won't see updates
shopt -s histappend
PROMPT_COMMAND="smile"
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups