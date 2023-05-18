#!/bin/bash

set -e

git submodule init
git submodule update

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

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
