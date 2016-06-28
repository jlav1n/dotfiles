# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PATH=/home/camp/bin:$PATH
alias ci='camp-info'
alias cia='camp-info --all'
alias cls='printf "\033c"'
alias dir='ls -l --color=auto'
alias ll='ls -l --color=auto'
alias S='screen -c ~/.u/jlavin/screenrc -x -S ${1:-$USER} || screen -c ~/.u/jlavin/screenrc -S ${1:-$USER}'
alias sl='screen -ls'
alias T=tmux_alias
alias tl='tmux -L jlavin ls'
bind '"\C-d":complete'

shopt -s histverify

function tmux_alias {
    tmux -f ~/.u/jlavin/tmux.conf -L jlavin attach -t ${1:-$USER} || tmux -f ~/.u/jlavin/tmux.conf -L jlavin new -s ${1:-$USER}
}

# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   username@Machine ~/dev/dir[master]$   # clean working directory
#   username@Machine ~/dev/dir[master*]$  # dirty working directory
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PROMPT_DIRTRIM=3
export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

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

alias prove='/home/camp/.plenv/shims/prove'

export PERLDOC_PAGER='less -+C'
