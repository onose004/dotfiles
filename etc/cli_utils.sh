#!/bin/bash
# sudo required

# ------------------------------------------------------------------------------
# PLUGIN MANAGER

# tpm for tmux
if [[ ! -d $HOME/.tmux/plugins ]]; then
  # install
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
else
  # update
  ~/.tmux/plugins/tpm/bin/update_plugins
fi

# neobundle for vim
[[ ! -d $HOME/.vim/bundle ]] && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +NeoBundleInstall +qall

# ------------------------------------------------------------------------------
# SHELL UTILS

# zprezto
if [[ ! -d $HOME/.zprezto ]]; then
  # install
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  # update
  cd $ZPREZTODIR
  git pull
  git submodule update --init --recursive
fi

# bats-core for testing
hash bats || {
  git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
  cd /tmp/bats-core
  ./install.sh /usr/local
}

# fzf
if [[ ! -d $HOME/.fzf ]]; then
  # install
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  yes | $HOME/.fzf/install
else
  # update
  cd $HOME/.fzf
  [ "`git pull`" = "Already up to date." ] || {
    yes | ./install
  }
fi

pkg_install tree
