#! /bin/sh

brew install zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

zsh

brew install lua
brew reinstall vim --with-lua