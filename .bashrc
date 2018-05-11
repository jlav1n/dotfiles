# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PATH=$HOME/bin:$HOME/perl5/bin:$PATH
alias cls='printf "\033c"'
alias g=git
alias gg='git grep'
alias gst='git status'
alias hg='history | grep'
alias ll='ls -l -G'
alias r='ssh -l root'
alias T=tmux_alias
alias tl='tmux -L jlavin ls'
alias vi=vim
alias w=whois

bind '"\C-d":complete'
bind -m vi-insert "\C-l":clear-screen

shopt -s histverify

source ~/.git-completion.bash
source ~/.git-prompt.sh

function tmux_alias {
    tmux -f ~/.tmux.conf -L jlavin attach -t ${1:-$USER} || tmux -f ~/.tmux.conf -L jlavin new -s ${1:-$USER}
}

export PROMPT_DIRTRIM=3
export PROMPT_COMMAND='__git_ps1 "\u@\h \[\033[1;33m\]\w\[\033[0m\]" "\\\$ "'
export GIT_PS1_SHOWDIRTYSTATE=1

export HISTTIMEFORMAT="%F %T "
export EDITOR=vim

alias fixssh='export $(tmux showenv SSH_AUTH_SOCK)'
#alias fixssh='export $(tmux show-env | grep SSH_AUTH_SOCK)'

export PERLDOC_PAGER='less -+C'

# local perl5
#eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

#export TERM=xterm-256color
