#!/bin/bash

# ------------------------------------------------------------------------------
# VARIABLES

FORMULA="git tmux zsh vim make curl"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # Ubuntu 16.04 
  APT=apt-get
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS
  APT=brew
fi

# ------------------------------------------------------------------------------
# PRE-INSTALL

if [[ "$OSTYPE" == "darwin"* ]]; then
  # settings
  defaults write com.apple.finder AppleShowAllFiles TRUE
  defaults write com.apple.finder CreateDesktop -boolean false

  xcode-select --install
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# ------------------------------------------------------------------------------
# UPDATE

$APT update

# ------------------------------------------------------------------------------
# INSTALL FORMULA

$APT install -y $FORMULA


# ------------------------------------------------------------------------------
# POST-INSTALL

chsh -s `which zsh`

# ------------------------------------------------------------------------------
# INSTALL DOTFILES

# git clone https://github.com/onose004/dotfiles $HOME/dotfiles
cd $HOME/dotfiles
make install

# ------------------------------------------------------------------------------
exit $?
