#!/bin/bash

[[ "$OSTYPE" == "darwin"* ]] && {
  # settings
  defaults write com.apple.finder AppleShowAllFiles TRUE
  defaults write com.apple.finder CreateDesktop -boolean false
}
