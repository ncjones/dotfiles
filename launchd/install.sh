#!/bin/bash

set -e

plist_file=~/Library/LaunchAgents/brew.update.plist


function install() {
  ln -sf ~/dotfiles/launchd/brew.update.plist $plist_file
  launchctl unload "$plist_file" 2>/dev/null || true
  launchctl load "$plist_file"
}

type launchctl > /dev/null && install
