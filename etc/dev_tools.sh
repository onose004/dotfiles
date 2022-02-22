#!/bin/bash

# nvim

hash nvim || {
  echo "Installing nvim..."
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Ubuntu / CentOS
    source /etc/os-release
    if [[ "$NAME" == "Ubuntu" ]]; then
      apt-get install -y software-properties-common
      add-apt-repository ppa:neovim-ppa/stable
      apt-get update -y
      apt-get install -y neovim
    elif [[ "$NAME" == "CentOS Linux" ]]; then
      yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
      yum install -y neovim python3-neovim
    fi
  elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    # Raspbian
    echo "Not Implemented"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # MacOS
    brew install neovim
  fi
}

# ------------------------------------------------------------------------------
# Repo Management

# ghq

hash ghq || {
  echo "Installing ghq..."
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Ubuntu / CentOS
    source /etc/os-release
    git clone https://github.com/x-motemen/ghq /tmp/ghq
    pushd /tmp/ghq
    make install
    popd
  elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    # Raspbian
    echo "Not Implemented"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # MacOS
    brew install ghq
  fi
}

# ------------------------------------------------------------------------------
# Editor 

# mkdir -p $HOME/.config/nvim
# ln -s $HOME/dotfiles/.vimrc $HOME/.config/nvim/init.vim
# ln -s $HOME/dotfiles/.vim/coc-settings.json $HOME/.config/nvim
