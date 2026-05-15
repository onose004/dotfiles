#!/bin/bash

set -euo pipefail

echo "Updating dotfiles..."
cd "$HOME/dotfiles" || exit 1
git pull

make deploy
make install
