#!/bin/bash
# sudo required

# node

hash node || {
  echo "Installing node..."
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Ubuntu / CentOS
    source /etc/os-release
    if [[ "$NAME" == "Ubuntu" ]]; then
      apt install -y nodejs npm
      npm install n -g
      n stable
      apt purge -y nodejs npm
    elif [[ "$NAME" == "CentOS Linux" ]]; then
      yum install -y nodejs npm
      npm install n -g
      n stable
      yum purge -y nodejs npm
    fi
  elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    # Raspbian
    echo "Not Implemented"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # MacOS
    brew install n
    n stable
  fi
}

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

# vim-plug for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall

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

$HOME/dotfiles/bin/pkg_install tree hub

exit 0
