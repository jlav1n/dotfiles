fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit && compinit
set -o vi
eval "$($(brew --prefix)/bin/brew shellenv)"

export PATH=$HOME/bin:$PATH

# shell history
bindkey "^R" history-incremental-search-backward

# incremental history sharing for zsh + tmux
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# general aliases
alias aws-profile="grep 'staff@' ~/.aws/config | cut -f2 -d' ' | tr ']' ' '"
alias glcoud=gcloud
alias ll='ls -l'
alias pbopcy=pbcopy
alias pbocpy=pbcopy

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
alias gd='git diff'
alias gg='git grep'
#alias gpsup='glab mr create --fill --web --target-branch $(git rev-parse --abbrev-ref --symbolic-full-name @{upstream} | cut -f2- -d"/" || git remote show origin | awk "/HEAD branch/ {print \$NF}")'
alias gpsup='glab mr create --fill --web --target-branch $(git rev-parse --abbrev-ref --symbolic-full-name @{upstream} | sed "s|^origin/||" || git remote show origin | awk "/HEAD branch/ {print \$NF}")'
alias grep='grep -w'
alias gst='git status'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias git-clean-merged='git branch --merged | grep -vE "\*|main|master" | xargs -n 1 git branch -d'

# Git completion settings: prefer local branches when checking out
zstyle ':completion:*:*:git-checkout:*' tag-order 'local-branches' 'branch'
zstyle ':completion:*:*:git-checkout:*' local-branches true
zstyle ':completion:*:*:git-checkout:*' remote-branches false

# Git switch to branch (optionally create new) with tracking
gco() {
    local branch=""
    local create_new=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -b)
                create_new=true
                shift
                branch="$1"
                ;;
            *)
                branch="$1"
                ;;
        esac
        shift
    done

    if [ -z "$branch" ]; then
        echo "Usage:"
        echo "  gco -b <new-branch>   # create and track from current branch"
        echo "  gco <existing-branch> # switch to existing branch"
        return 1
    fi

    if $create_new; then
        #echo "Running: git switch -c $branch --track"
        git switch -c "$branch" --track
    else
        #echo "Running: git switch $branch"
        git switch "$branch"
    fi
}
compdef _git gco=git-switch

# Open all files from a Git commit in Vim
gcv() {
    vim $(git diff-tree --no-commit-id --name-only -r "$1")
}

# Get GCP role permissions and save to file
alias gcp-get-role='function _gcp_get_role() {
  local role="${1#roles/}"
  gcloud iam roles describe roles/$role --format="value(includedPermissions)" | sed -e "s/;/\\n/g" > ~/src/google/roles/$role
}; _gcp_get_role'

source ~/.git-prompt.sh
precmd () { __git_ps1 "%F{yellow}%~" " $ " "\n%s" }
export GIT_PS1_SHOWCOLORHINTS=1

# Python pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/src/google-cloud-sdk/path.zsh.inc' ]; then . '~/src/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/src/google-cloud-sdk/completion.zsh.inc' ]; then . '~/src/google-cloud-sdk/completion.zsh.inc'; fi

# Databricks
databricks completion zsh > $(brew --prefix)/share/zsh/site-functions/_databricks

# Jump
eval "$(jump shell)"

export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C ~/.config/tfenv/versions/1.13.3/terraform terraform
