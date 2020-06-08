#!/bin/bash

# This command installs dotfiles in a clean environment. The first step is to
# installs the commands needed to install dotfiles. The next step is to clone
# dotfiles and deploy the configuration files and install plugins.
# It is assumed that this script by itself will accomplish its purpose.
# Additional development libraries will be need to be installed later step.

echo "
__        __   _                          _
\ \      / /__| | ___ ___  _ __ ___   ___| |
 \ \ /\ / / _ \ |/ __/ _ \| '_ ' _ \ / _ \ |
  \ V  V /  __/ | (_| (_) | | | | | |  __/_|
   \_/\_/ \___|_|\___\___/|_| |_| |_|\___(_)
"

# ------------------------------------------------------------------------------
# VARIABLES

# ROOT
ROOT="$HOME/dotfiles"

# Dotfiles repo
DOT_REPO="https://github.com/onose004/dotfiles"

# Fundamentals
FORMULA="git tmux zsh vim make curl bats"

# APT={package manager command}
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # Ubuntu / CentOS
  source /etc/os-release
  [[ "$NAME" == "Ubuntu" ]] && APT=apt-get
  [[ "$NAME" == "CentOS Linux" ]] && APT=yum
elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
  # Raspbian
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
  ! brew -v && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# ------------------------------------------------------------------------------
# UPDATE AND INSTALL FORMULA

if [[ "$APT" == "brew" ]]; then
  $APT update
else
  $APT update -y
fi

for package in $FORMULA
do
  if !(type "$package" > /dev/null 2>&1); then
      if [[ "$APT" == "brew" ]]; then
        $APT install $package
      else
        $APT install -y $package
      fi
  fi
done



# ------------------------------------------------------------------------------
# POST-INSTALL

[[ ! `basename $SHELL` == "zsh" ]] && chsh -s `which zsh`

# ------------------------------------------------------------------------------
# CLONE DOTFILES

[[ ! -d $HOME/dotfiles ]] && git clone $DOT_REPO $HOME/dotfiles
cd $HOME/dotfiles
make install

# ------------------------------------------------------------------------------
# TEST

bats $HOME/dotfiles/tests/unit.*.bats
test_ret=$?

exit $test_ret
