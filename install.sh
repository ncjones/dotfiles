#!/bin/sh

basedir=$(cd $(dirname $0) && pwd)
dirlist=$(find $basedir \
            -maxdepth 1 \
            -mindepth 1 \
            -type d \
            -not -name '.*' \
            -printf '%f\n' \
        )
for d in $dirlist; do
    echo installing $d
    stow -d $basedir -t $HOME $d
done
