export ZSH="$HOME/.oh-my-zsh"

export CLICOLOR=1
export VISUAL=vim
export EDITOR="$VISUAL"

ZSH_THEME="none"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

alias ls='ls -Fa'
alias recunzip="find . -name '*.zip' -execdir unzip {} \;"
alias v='vi'

function gitsha(){
    REV_IDX=${1:-0}
    COMMIT_SHA=$(git rev-parse HEAD^$REV_IDX)
    echo "${COMMIT_SHA}" | tr -d '\n' | pbcopy
    COMMIT_DESC=$(git rev-list --format=%B --max-count=1 HEAD^$REV_IDX)
    echo "Copied to clipboard: ${COMMIT_DESC}"
}

export FZF_DEFAULT_COMMAND='fd --type f'

eval "$(starship init zsh)"
