# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PATH=$HOME/bin:/opt/endpoint/perl-5.22.0/bin:~camp/bin:$HOME/perl5/bin:$PATH
alias ci='camp-info'
alias cia='camp-info --all'
alias cls='printf "\033c"'
alias gst='git status'
alias hg='history | grep'
alias ll='ls -l --color=auto'
alias S='screen -c ~/.u/jlavin/screenrc -x -S ${1:-$USER} || screen -c ~/.u/jlavin/screenrc -S ${1:-$USER}'
alias sl='screen -ls'
alias T=tmux_alias
alias tl='tmux -L jlavin ls'
bind '"\C-d":complete'

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

# ssh agent handling
mkdir -p ~/.state
if [ ! -z "$SSH_AUTH_SOCK" ]; then
    screen_ssh_agent=${HOME}/.state/ssh-agent-screen
    if [ "$TERM" = "screen" ]; then
        SSH_AUTH_SOCK=${screen_ssh_agent}; export SSH_AUTH_SOCK
    else
        ln -snf ${SSH_AUTH_SOCK} ${screen_ssh_agent}
    fi
fi
alias fixssh='export $(tmux showenv SSH_AUTH_SOCK)'
#alias fixssh='export $(tmux show-env | grep SSH_AUTH_SOCK)'

export PERLDOC_PAGER='less -+C'

# local perl5
#eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

#export GIT_CONFIG=${HOME}/.u/jlavin/git/config
#alias prove='/home/camp/.plenv/shims/prove -r'
#alias re='i/bin/restart'
#export TERM=xterm-256color
