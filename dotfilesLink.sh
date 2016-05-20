#!/bin/sh
mkdir -p ~/.vim/bundle
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/colors ~/.vim
ln -sf ~/dotfiles/.wgetrc ~/.wgetrc
ln -sf ~/dotfiles/bundle ~/.vim
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
