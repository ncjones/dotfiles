export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
plugins=(aws git z ag)
type dircolor &> /dev/null && eval `dircolors`
source $ZSH/oh-my-zsh.sh
source ~/.path
source ~/.aliases
bindkey '^R' history-incremental-pattern-search-backward
export EDITOR=lvim
export TERM=xterm-256color
export NVM_DIR="$HOME/.nvm"
. "${NVM_DIR}/nvm.sh"
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# If rbenv exists, init shims autocompletion
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi
