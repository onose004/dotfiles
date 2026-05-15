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

# ------------------------------------------------------------------------------
# ghq

if ! command -v ghq &>/dev/null; then
  ARCH=$(uname -m)
  case $ARCH in
  x86_64) ARCH=amd64 ;;
  aarch64) ARCH=arm64 ;;
  esac
  GHQ_VERSION="1.6.2"
  curl -fsSL \
    "https://github.com/x-motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_linux_${ARCH}.zip" \
    -o /tmp/ghq.zip
  unzip -o /tmp/ghq.zip -d /tmp/ghq
  install -m 755 "/tmp/ghq/ghq_linux_${ARCH}/ghq" /usr/local/bin/ghq
  rm -rf /tmp/ghq.zip /tmp/ghq
fi

# ------------------------------------------------------------------------------
# node (via n) — skip in CI

if [[ "${CI:-}" != "true" ]] && ! command -v node &>/dev/null; then
  if command -v apt-get &>/dev/null; then
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs npm
  elif command -v dnf &>/dev/null; then
    dnf install -y nodejs npm
  fi
  npm install -g n
  n stable
  if command -v apt-get &>/dev/null; then
    DEBIAN_FRONTEND=noninteractive apt-get purge -y nodejs npm
  elif command -v dnf &>/dev/null; then
    dnf remove -y nodejs npm
  fi
fi
