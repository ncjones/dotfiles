export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
DISABLE_AUTO_UPDATE="true"
plugins=(aws git colored-man z)
eval `dircolors`
eval "$(rbenv init -)"
source $ZSH/oh-my-zsh.sh
source ~/.path
source ~/.aliases
bindkey '^R' history-incremental-pattern-search-backward
export TERM=xterm-256color
