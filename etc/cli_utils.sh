#!/bin/bash
# sudo required

# ------------------------------------------------------------------------------
# PLUGIN MANAGER

# tpm for tmux
echo "# tpm"
if [[ ! -d $HOME/.tmux/plugins ]]; then
  # install
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
  # update
  $HOME/.tmux/plugins/tpm/bin/update_plugins
fi

# neobundle for vim
echo "# neobundle"
[[ ! -d $HOME/.vim/bundle ]] && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +NeoBundleInstall +qall

# ------------------------------------------------------------------------------
# SHELL UTILS

# zprezto
echo "# zprezto"
if [[ ! -d $HOME/.zprezto ]]; then
  # install
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  # update
  pushd $ZPREZTODIR
  git pull
  git submodule update --init --recursive
  popd
fi

# bats-core for testing
echo "# bats"
hash bats || {
  git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
  pushd /tmp/bats-core
  ./install.sh /usr/local
  popd
}

# fzf
echo "# fzf"
if [[ ! -d $HOME/.fzf ]]; then
  # install
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  yes | $HOME/.fzf/install
else
  # update
  pushd $HOME/.fzf
  [ "`git pull`" = "Already up to date." ] || {
    yes | ./install
  }
  popd
fi

$HOME/dotfiles/bin/pkg_install tree

exit 0
