#!/usr/bin/env bats

# Fundamentals
@test "git installed" {
  run command -v git
  [ "$status" -eq 0 ]
}

@test "tmux installed" {
  run command -v tmux
  [ "$status" -eq 0 ]
}

@test "zsh installed" {
  run command -v zsh
  [ "$status" -eq 0 ]
}

@test "nvim installed" {
  run command -v nvim
  [ "$status" -eq 0 ]
}

@test "make installed" {
  run command -v make
  [ "$status" -eq 0 ]
}

@test "curl installed" {
  run command -v curl
  [ "$status" -eq 0 ]
}

# CLI utils
@test "fzf installed" {
  run command -v fzf
  [ "$status" -eq 0 ]
}

# Dev tools
@test "ghq installed" {
  run command -v ghq
  [ "$status" -eq 0 ]
}

# Symlinks
@test "symlink .vimrc exists" {
  [ -L "$HOME/.vimrc" ]
}

@test "symlink .zshrc exists" {
  [ -L "$HOME/.zshrc" ]
}

@test "symlink .tmux.conf exists" {
  [ -L "$HOME/.tmux.conf" ]
}

@test "symlink .bashrc exists" {
  [ -L "$HOME/.bashrc" ]
}

# nvim
@test "nvim opens without error" {
  run nvim --headless -u "$HOME/.vimrc" +qa
  [ "$status" -eq 0 ]
}
