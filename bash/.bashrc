# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

. ~/.bash_aliases
. ~/.aliases
. /etc/bash_completion

# set LS_COLORS env var
eval `dircolors`

if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

export PAGER='vim -R -u ~/.vim_pager_rc -c AnsiEsc -'

function man {
  PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -u ~/.vim_man_pager_rc \
        -\"" \
    /usr/bin/man $*
}

# Truncate __git_ps1 and display elipses if it exceeds a maximum length.
function __git_ps1_trunc {
    local max_length=$1
    local printf_format=$2
    local git_ps1=`__git_ps1 "%s"`
    if [ -z $git_ps1 ]; then
        exit
    fi
    if [ ${#git_ps1} -gt $max_length ]; then
        git_ps1=$(echo "$git_ps1" | head -c $[$max_length - 3])...
    fi
    printf "$printf_format" $git_ps1
}

export PS1='\w\[\e[0;32m\]$(__git_ps1_trunc 28 " %s")\[\e[m\]\n$ '

. ~/z/z.sh
. ~/.path
