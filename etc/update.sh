#!/bin/bash
# update.sh

echo "Updating dotfiles..."
cd $HOME/dotfiles || exit 1
git pull 

make deploy || exit 1  # Create symlinks to home directory
source $HOME/.bashrc
source $HOME/.zshrc
make install || exit 1 # Install plugins/utilities/applications
make test
exit 0
