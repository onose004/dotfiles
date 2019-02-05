#!/bin/bash


# NeoBundle のインストール
if [ -e ~/.vim/bundle ]; then
  echo [exists] NeoBundle
else
  echo [installed] NeoBundle
  mkdir -p ~/.vim/bundle
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

