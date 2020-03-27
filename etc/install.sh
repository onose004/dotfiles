#!/bin/bash

# ------------------------------------------------------------------------------
# INSTALL TOOLS 

# pyenv
[[ ! -d $HOME/.pyenv ]] && git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

# zprezto
[[ ! -d $HOME/.zprezto ]] && git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# tpm
[[ ! -d $HOME/.tmux/plugins ]] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neobundle
[[ ! -d $HOME/.vim/bundle ]] && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +NeoBundleInstall +qall

# ------------------------------------------------------------------------------
exit 0
