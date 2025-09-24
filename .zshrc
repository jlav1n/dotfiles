fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit && compinit
set -o vi
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=$HOME/bin:$PATH

# shell history
bindkey "^R" history-incremental-search-backward

# incremental history sharing for zsh + tmux
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# general aliases
alias ll='ls -l'
alias aws-profile="grep 'staff@' ~/.aws/config | cut -f2 -d' ' | tr ']' ' '"

# Git
function git_current_branch() {
    local ref
    ref=$(git symbolic-ref --quiet HEAD)
    echo ${ref#refs/heads/}
}
function gitvimdiff() {
    if [ -z "$1" ]; then
        echo "Usage: gitvimdiff <commit-sha>"
        return 1
    fi
    vim $(git show --stat "$1" | grep "|" | awk '{print $1}' | sort | uniq)
}
alias g=git
alias ga='git add'
alias gc='git commit'
alias gcm='git checkout main'
alias gco='git checkout'
alias gd='git diff'
alias gg='git grep'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gst='git status'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias git-clean-merged='git branch --merged | grep -vE "\*|main|master" | xargs -n 1 git branch -d'

# opens current Git directory in browser
alias ot='open "$(git config --get remote.origin.url | sed -E "s/git@([^:]+):/https:\/\/\1\//" | sed "s/\.git$//")"'

source ~/.git-prompt.sh
precmd () { __git_ps1 "%F{yellow}%~" " $ " "\n%s" }
export GIT_PS1_SHOWCOLORHINTS=1

# Python pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/l537634/src/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/l537634/src/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/l537634/src/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/l537634/src/google-cloud-sdk/completion.zsh.inc'; fi

# Databricks
databricks completion zsh > $(brew --prefix)/share/zsh/site-functions/_databricks
