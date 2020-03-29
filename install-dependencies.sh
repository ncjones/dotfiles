#!/bin/bash
type apt-get &> /dev/null && sudo apt-get install -y \
  python-dev \
  python3-dev \
  build-essential \
  cmake \
  vim-nox \
  tmux \
  stow \
  zsh \
  ctags \
  shellcheck \
  silversearcher-ag \
  jq \
  socat

type brew &> /dev/null && brew install \
  wget \
  python3 \
  cmake \
  vim \
  tmux \
  stow \
  zsh \
  ctags \
  shellcheck \
  ag \
  jq \
  socat 

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# sudo npm install -g xml2json-cli
