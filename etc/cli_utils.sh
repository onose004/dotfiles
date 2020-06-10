#!/bin/bash
# sudo required

# ------------------------------------------------------------------------------
# PLUGIN MANAGER

# tpm for tmux
if [[ ! -d $HOME/.tmux/plugins ]]; then
  echo "Installing tpm..."
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
  echo "Updating tpm..."
  $HOME/.tmux/plugins/tpm/bin/update_plugins
fi

# neobundle for vim
[[ ! -d $HOME/.vim/bundle ]] && {
  echo "Installing NeoBundle..."
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
}
vim +NeoBundleInstall +qall

# ------------------------------------------------------------------------------
# SHELL UTILS

# zprezto
if [[ ! -d $HOME/.zprezto ]]; then
  echo "Installing Zprezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  echo "Updating Zprezto..."
  pushd $ZPREZTODIR
  git pull
  git submodule update --init --recursive
  popd
fi

# bats-core for testing
hash bats || {
  echo "Installing bats..."
  git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
  pushd /tmp/bats-core
  ./install.sh /usr/local
  popd
}

# fzf
if [[ ! -d $HOME/.fzf ]]; then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  yes | $HOME/.fzf/install
else
  echo "Updating fzf..."
  pushd $HOME/.fzf
  [ "`git pull`" = "Already up to date." ] || {
    yes | ./install
  }
  popd
fi

$HOME/dotfiles/bin/pkg_install tree

exit 0
