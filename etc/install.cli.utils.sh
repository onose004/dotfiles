#!/bin/bash

# ------------------------------------------------------------------------------
# PLUGIN MANAGER

# tpm
[[ ! -d $HOME/.tmux/plugins ]] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neobundle
[[ ! -d $HOME/.vim/bundle ]] && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +NeoBundleInstall +qall

# ------------------------------------------------------------------------------
# SHELL UTILS

# zprezto
[[ ! -d $HOME/.zprezto ]] && git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

FORMULA="fzf tree"

# ------------------------------------------------------------------------------
exit 0
