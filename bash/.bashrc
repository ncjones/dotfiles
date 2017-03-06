# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

if [[ -f /etc/bash_completion ]]; then
  . /etc/bash_completion
fi

# set LS_COLORS env var
type dircolors &> /dev/null && eval `dircolors`

. ~/.path
. ~/.bash_aliases
. ~/.aliases
