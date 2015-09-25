HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename '/home/root/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#### our custom stuff below

path+=('/home/root/bin')
export PATH

setopt PROMPT_SUBST

# this is taken from grml's zshrc
function zrcautoload() {
    emulate -L zsh
    setopt extended_glob
    local fdir ffile
    local -i ffound

    ffile=$1
    (( found = 0 )) 
    for fdir in ${fpath} ; do 
        [[ -e ${fdir}/${ffile} ]] && (( ffound = 1 )) 
    done 

    (( ffound == 0 )) && return 1
    if [[ $ZSH_VERSION == 3.1.<6-> || $ZSH_VERSION == <4->* ]] ; then 
        autoload -U ${ffile} || return 1
    else 
        autoload ${ffile} || return 1
    fi
    return 0
}
zrcautoload vcs_info || vcs_info() {return 1}
# end grml

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }

autoload -U colors && colors
PROMPT='%(!..%n@)%m:%~${vcs_info_msg_0_}%# '
RPROMPT='%{$fg[magenta]%}zsh%{$reset_color%}'

MAIL=0

alias cls=clear
alias cn='perl -wc'
alias cpan='perl -MCPAN -e shell'
alias cx='chmod +x'
alias del='rm -i'
alias dir='ls -l --color=auto'
alias dird='ls -l $* |grep "^d"'
alias gs='git status -sb'
alias h='history 20'
alias hg='history | grep '
alias hi='echo "Hello, pleased to see you."'
alias m='mutt -z'
alias mailmsgs='tail -74 /var/log/maillog'
alias msgs='tail -74 /var/log/messages'
alias mv='mv -i'
alias pg='ps waxu | grep '
alias proveall='prove -j9 --state=slow,save -lr t'
alias r='ssh -l root'
alias re='yes | i/bin/restart'
alias recon='i/bin/interchange -recon '
alias reb='yes | i/bin/restart; tail -f i/debug.log i/error.log'
alias ree='yes | i/bin/restart; tail -f i/error.log'
alias red='yes | i/bin/restart; tail -f i/debug.log'
alias sx='screen -x'
alias vi=vim
alias wi=whoami

setopt no_hist_verify

export PAGER="less -R -X -x4"
export MINIVEND_DISABLE_UTF8=1
export TERM=xterm
