alias c='perl -pe "s/^\s*#\s*use\s+vars\s+/ use vars /" | perl -Mstrict -wc'
alias cls=clear
alias cn='perl -wc'
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

bindkey -v
