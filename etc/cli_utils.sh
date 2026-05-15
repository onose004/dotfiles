#!/bin/bash

set -euo pipefail

# ------------------------------------------------------------------------------
# zprezto

if [[ ! -d $HOME/.zprezto ]]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
  pushd "${ZDOTDIR:-$HOME}/.zprezto"
  git pull
  git submodule update --init --recursive
  popd
fi

# ------------------------------------------------------------------------------
# tpm

if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  "$HOME/.tmux/plugins/tpm/bin/update_plugins" all
fi

# ------------------------------------------------------------------------------
# vim-plug

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nvim PlugInstall (skip in CI)
if [[ "${CI:-}" != "true" ]]; then
  nvim +PlugInstall +qall
fi

# ------------------------------------------------------------------------------
# tree

command -v tree &>/dev/null || {
  if command -v apt-get &>/dev/null; then
    DEBIAN_FRONTEND=noninteractive apt-get install -y tree
  elif command -v dnf &>/dev/null; then
    dnf install -y tree
  fi
}

# ------------------------------------------------------------------------------
# bats-core

if ! command -v bats &>/dev/null; then
  git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
  pushd /tmp/bats-core
  ./install.sh /usr/local
  popd
  rm -rf /tmp/bats-core
fi

# ------------------------------------------------------------------------------
# fzf

if [[ ! -d $HOME/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
else
  pushd "$HOME/.fzf"
  git pull
  popd
fi
"$HOME/.fzf/install" --bin
install -m 755 "$HOME/.fzf/bin/fzf" /usr/local/bin/fzf
