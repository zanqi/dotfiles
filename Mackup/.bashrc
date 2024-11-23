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
BYELLOW='\[\e[1;33m\]'


function timer_start {
  timer=${timer:-$SECONDS}
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=smile

function smile {
    if [ "$?" -eq "0" ]
    then
        #smiley
        SC="${GREEN}:)"
    else
        #frowney
        SC="${RED}:("
    fi
    HC="${BYELLOW}"
    DF='\[\e[0m\]'
	elaps=$(($SECONDS - $timer))
  	unset timer
    PS1="\n${elaps}s @${HC}\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] ${SC}${DF} \n$ "
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

bind 'set completion-ignore-case on'

