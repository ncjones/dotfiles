#!/bin/sh

# fetch new versions of Homebrew + all formulae
brew update

# upgrade outdated formulae + casks
brew upgrade

# remove outdated downloads for all formulae + casks
brew cleanup

# check system for potential problems
brew doctor

# check for missing dependencies
brew missing

