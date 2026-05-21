#!/bin/bash
# macOS-only system defaults. Idempotent; safe to re-run.

set -euo pipefail

[[ "$OSTYPE" == "darwin"* ]] || exit 0

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder CreateDesktop -bool false

killall Finder 2>/dev/null || true
