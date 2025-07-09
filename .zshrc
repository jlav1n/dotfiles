fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit && compinit
set -o vi
alias gst='git status'

source ~/.git-prompt.sh
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
precmd () { __git_ps1 "%n" ":%~$ " "|%s" }
export GIT_PS1_SHOWCOLORHINTS=1
