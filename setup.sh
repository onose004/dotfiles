#!/bin/bash
# Linux: sudo bash setup.sh
# macOS: bash setup.sh   (do NOT sudo; Homebrew refuses to run as root)

set -euo pipefail

echo "
__        __   _                          _
\ \      / /__| | ___ ___  _ __ ___   ___| |
 \ \ /\ / / _ \ |/ __/ _ \| '_ ' _ \ / _ \ |
  \ V  V /  __/ | (_| (_) | | | | | |  __/_|
   \_/\_/ \___|_|\___\___/|_| |_| |_|\___(_)
"

# ------------------------------------------------------------------------------
# DOTFILES ROOT

ROOT="${DOTFILES_ROOT:-$HOME/dotfiles}"
DOT_REPO="https://github.com/onose004/dotfiles"

if [[ -z "${DOTFILES_ROOT:-}" ]]; then
  if [[ ! -d "$ROOT" ]]; then
    git clone "$DOT_REPO" "$ROOT"
  else
    git -C "$ROOT" pull
  fi
fi

# ------------------------------------------------------------------------------
# PACKAGE INSTALL

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS: bootstrap Homebrew if missing, then defer to Brewfile.
  if ! command -v brew &>/dev/null; then
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Make brew available in this shell for the rest of setup (Apple Silicon path).
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  brew update
  brew bundle --file="$ROOT/Brewfile"
  bash "$ROOT/etc/macos.sh"
elif command -v apt-get &>/dev/null; then
  DEBIAN_FRONTEND=noninteractive apt-get update -y
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git tmux zsh neovim make curl unzip
elif command -v dnf &>/dev/null; then
  dnf install -y epel-release 2>/dev/null || true
  dnf install -y --allowerasing git tmux zsh neovim make curl unzip
else
  echo "Unsupported platform" >&2
  exit 1
fi

# ------------------------------------------------------------------------------
# DEPLOY

cd "$ROOT"
make deploy
make install
