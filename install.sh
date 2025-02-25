#!/bin/bash

set -e

basedir=$(cd "$(dirname "$0")" && pwd)
dirlist="$*"
if [ -z "${dirlist}" ]; then
  dirlist=$(find "${basedir}" \
    -maxdepth 1 \
    -mindepth 1 \
    -type d \
    -not -name '.*' \
    | sed 's/[^/]*\///g'
  )
fi

for d in $dirlist; do
    echo installing "$d"
    install_script=$basedir/$d/install.sh
    if [ -x "$install_script" ]; then
        $install_script || echo "ERROR: $install_script"
    fi
    stow \
      --dir "$basedir" \
      --target "$HOME" \
      --ignore 'install.sh' \
      --ignore '^[^\.].*' \
      "$d"
done
