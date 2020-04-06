#          _
#  _______| |__  _ __ ___
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__
# /___|___/_| |_|_|  \___|
#

# export LC_ALL=ja_JP.UTF-8

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# zprezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

source $HOME/.zsh/.alias.zsh
export PATH="$HOME/dotfiles/bin:${PATH}"

[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
