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
  nvm \
  tmux \
  stow \
  zsh \
  ctags \
  shellcheck \
  ag \
  jq \
  yarn \
  socat

type brew &> /dev/null && brew install --cask \
  font-mplus-nerd-font
