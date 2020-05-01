#!/bin/bash

set -e

basedir=$(cd `dirname $0` && pwd)
vim_plug_url=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim_plug_file=$basedir/.vim/autoload/plug.vim
if [ ! -f $vim_plug_file ]; then
    echo downloading $vim_plug_url
    mkdir -p $(dirname $vim_plug_file)
    wget --quiet -O $vim_plug_file $vim_plug_url
fi
