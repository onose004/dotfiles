#!/bin/bash
# Run as root: sudo bash setup.sh

set -euo pipefail

echo "
__        __   _                          _
\ \      / /__| | ___ ___  _ __ ___   ___| |
 \ \ /\ / / _ \ |/ __/ _ \| '_ ' _ \ / _ \ |
  \ V  V /  __/ | (_| (_) | | | | | |  __/_|
   \_/\_/ \___|_|\___\___/|_| |_| |_|\___(_)
"

# ------------------------------------------------------------------------------
# PACKAGE MANAGER

if command -v apt-get &>/dev/null; then
  pkg_update() { DEBIAN_FRONTEND=noninteractive apt-get update -y; }
  pkg_install() { DEBIAN_FRONTEND=noninteractive apt-get install -y "$@"; }
elif command -v dnf &>/dev/null; then
  pkg_update() { dnf install -y epel-release 2>/dev/null || true; }
  pkg_install() { dnf install -y "$@"; }
else
  echo "Unsupported package manager" >&2
  exit 1
fi

# ------------------------------------------------------------------------------
# FUNDAMENTALS

pkg_update
pkg_install git tmux zsh neovim make curl unzip

# ------------------------------------------------------------------------------
# DOTFILES

ROOT="${DOTFILES_ROOT:-$HOME/dotfiles}"
DOT_REPO="https://github.com/onose004/dotfiles"

if [[ -z "${DOTFILES_ROOT:-}" ]]; then
  if [[ ! -d "$ROOT" ]]; then
    git clone "$DOT_REPO" "$ROOT"
  else
    git -C "$ROOT" pull
  fi
fi

cd "$ROOT"
make deploy
make install
