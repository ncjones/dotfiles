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

dev_tools=~/Development/Tools
export ANDROID_HOME=$dev_tools/android-sdk
export ANDROID_KEYSTORE=/home/nathan/ownCloud/android.keystore
export KEEPER=~/Development/Code/keeper
export JBOSS_HOME=$KEEPER/jboss-odin
export CATALINA_HOME=$KEEPER/apache-tomcat-7.0.54
export JASPER_LICENSE_DIR=$KEEPER/reporting-bundle/license
export PATH="$HOME/.rvm/bin:$PATH"
export PATH=~/.local/bin:$PATH
export PATH=$PATH:$dev_tools/maven/bin
export PATH=$PATH:$dev_tools/roo/bin
export PATH=$PATH:$dev_tools/gradle/bin
export PATH=$PATH:$ANDROID_HOME/build-tools/android-4.4
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$dev_tools/apktool
export PATH=$PATH:$dev_tools/ant/bin
export PATH=$PATH:$dev_tools/leiningen
export PATH=$PATH:$dev_tools/activator-1.2.0-minimal
export PATH=$PATH:$dev_tools/liquibase
export PATH=$PATH:$dev_tools/heimdall/bin

