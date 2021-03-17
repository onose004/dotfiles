#!/bin/bash

# ------------------------------------------------------------------------------
# Lanugage

# Golang

hash go || {
  echo "Installing go..."
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Ubuntu / CentOS
    source /etc/os-release
    if [[ "$NAME" == "Ubuntu" ]]; then
      add-apt-repository ppa:longsleep/golang-backports
      apt update
      apt install -y golang-go
    elif [[ "$NAME" == "CentOS Linux" ]]; then
      yum install -y epel-release
      yum install -y golang
    fi
  elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    # Raspbian
    echo "Not Implemented"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # MacOS
    brew install go
  fi
}

# ------------------------------------------------------------------------------
# Repo Management

# ghq

# bats-core for testing
hash ghq || {
  echo "Installing ghq..."
  go get -u github.com/x-motemen/ghq
}

# ------------------------------------------------------------------------------
# Editor 

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
mkdir -p $HOME/.config/nvim
ln -s $HOME/dotfiles/.vimrc $HOME/.config/nvim/init.vim
