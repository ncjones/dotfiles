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

# If rbenv exists, init shims autocompletion
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi

# Define "light" and "dark" for manually switching iterm theme and set theme
# automatically based on OS setting.
# See: https://matthew.nz/view/automatic-dark-mode-for-iterm2
terminal_profile() { echo -e "\033]1337;SetProfile=$1\a" }
alias dark='export LC_APPEARANCE=dark && terminal_profile dark'
alias light='export LC_APPEARANCE=light && terminal_profile light'
if [ -z "$SSH_CLIENT" ]; then
  # Detect OSX dark mode
  appearance=$(defaults read -g AppleInterfaceStyle 2> /dev/null || echo "Light")
  if [ $appearance = 'Dark' ]; then
    dark
  else
    light
  fi
fi
