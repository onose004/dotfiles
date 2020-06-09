#!/bin/bash
# sudo required

# ------------------------------------------------------------------------------
# PLUGIN MANAGER

# tpm for tmux
[[ ! -d $HOME/.tmux/plugins ]] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neobundle for vim
[[ ! -d $HOME/.vim/bundle ]] && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +NeoBundleInstall +qall

# ------------------------------------------------------------------------------
# SHELL UTILS

# zprezto
if [[ ! -d $HOME/.zprezto ]]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  pushd $ZPREZTODIR
  git pull
  git submodule update --init --recursive
  popd
fi

# bats-core for testing
hash bats || {
  git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
  pushd /tmp/bats-core
  ./install.sh /usr/local
  popd
}

# fzf
if [[ ! -d $HOME/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  yes | $HOME/.fzf/install
else
  pushd $HOME/.fzf
  [ "`git pull`" = "Already up to date." ] || {
    yes | ./install
  }
  popd
fi

pkg_install tree

# ------------------------------------------------------------------------------
exit 0
