#!/bin/bash
# update.sh


echo "Updating dotfiles..."
cd $HOME/dotfiles || exit 1
git pull origin master

make deploy || exit 1  # Create symlinks to home directory
source $HOME/.bashrc
source $HOME/.zshrc
make install || exit 1 # Install plugins/utilities/applications

exit 0
