export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
DISABLE_AUTO_UPDATE="true"
plugins=(aws git z)
type dircolor &> /dev/null && eval `dircolors`
source $ZSH/oh-my-zsh.sh
source ~/.path
source ~/.aliases
bindkey '^R' history-incremental-pattern-search-backward
export EDITOR=vim
export TERM=xterm-256color
export NVM_DIR="$HOME/.nvm"
export NVM_DIR="$HOME/.nvm"
. "${NVM_DIR}/nvm.sh"
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
