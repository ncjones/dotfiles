# vim: filetype=sh
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
proxy='localhost:8888'
alias proxyon="\
  export http_proxy=http://$proxy && \
  export https_proxy=https://$proxy"
alias proxyoff='unset http_proxy https_proxy'
alias xclipin='xclip -i -selection clipboard'
alias xclipout='xclip -o -selection clipboard'
alias httpd='ruby -run -e httpd . -p 9090'
# cd to git root
alias gr='
 git branch > /dev/null 2>&1 || return 1
 cd "$(git rev-parse --show-cdup)".
'
