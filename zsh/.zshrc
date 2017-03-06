export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
DISABLE_AUTO_UPDATE="true"
plugins=(aws git colored-man z)
type dircolor &> /dev/null && eval `dircolors`
source $ZSH/oh-my-zsh.sh
source ~/.path
eval "$(rbenv init -)"
source ~/.aliases
bindkey '^R' history-incremental-pattern-search-backward
export TERM=xterm-256color
