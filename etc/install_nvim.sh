#!/bin/bash
# Install the official Neovim release build on Linux.
# Distro packages lag far behind (e.g. 0.6.1 on Ubuntu 22.04), so the release
# tarball is installed under /usr/local instead.
# To upgrade, bump NVIM_VERSION and re-run: bash etc/install_nvim.sh
# On macOS, Neovim comes from Brewfile instead.

set -euo pipefail

NVIM_VERSION="0.12.6"
PREFIX="/usr/local"

if [[ "$OSTYPE" == "darwin"* ]]; then
  exit 0
fi

if [[ "$("$PREFIX/bin/nvim" --version 2>/dev/null | head -n 1)" == "NVIM v${NVIM_VERSION}" ]]; then
  echo "Neovim v${NVIM_VERSION} is already installed"
  exit 0
fi

ARCH=$(uname -m)
case $ARCH in
aarch64) ARCH=arm64 ;;
esac

# Extract into a temp dir first so a failed download leaves the current install intact.
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
curl -fsSL \
  "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${ARCH}.tar.gz" \
  -o "$TMP/nvim.tar.gz"
mkdir -p "$TMP/nvim"
tar -xzf "$TMP/nvim.tar.gz" -C "$TMP/nvim" --strip-components=1

rm -rf "$PREFIX/nvim"
mv "$TMP/nvim" "$PREFIX/nvim"
mkdir -p "$PREFIX/bin"
ln -sfn "$PREFIX/nvim/bin/nvim" "$PREFIX/bin/nvim"

echo "Installed $("$PREFIX/bin/nvim" --version | head -n 1)"
