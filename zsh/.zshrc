export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
DISABLE_AUTO_UPDATE="true"
plugins=(git colored-man z)
eval `dircolors`
source $ZSH/oh-my-zsh.sh
source ~/.path
bindkey '^R' history-incremental-pattern-search-backward
export TERM=xterm-256color
