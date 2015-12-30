#!/bin/bash

basedir=$(cd $(dirname $0) && pwd)
mkdir -p $HOME/bin
stow \
  --dir $basedir \
  --ignore 'install.sh' \
  --target $HOME/bin \
  .
