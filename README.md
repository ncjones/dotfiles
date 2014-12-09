Dotfiles
========

Nathan's personal dotfiles.


Installing
----------

Installation simply requires creating symlinks in the users $HOME dir to each
dot file. All dot files can be installed using the install script (requires
`stow`):

    $ ./install.sh

Individual dot files can be installed with `stow`, for example (assuming this
dir is a child of $HOME):

    $ stow vim
