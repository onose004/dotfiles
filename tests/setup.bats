#!/usr/bin/env bats

# setup.bats
# verifies installation by setup.sh

@test "git installed" {
  run type git
  [ "$status" -eq 0 ]
}

@test "tmux installed" {
  run type tmux
  [ "$status" -eq 0 ]
}

@test "zsh installed" {
  run type zsh
  [ "$status" -eq 0 ]
}

@test "vim installed" {
  run type vim
  [ "$status" -eq 0 ]
}

@test "make installed" {
  run type make
  [ "$status" -eq 0 ]
}

@test "curl installed" {
  run type curl 
  [ "$status" -eq 0 ]
}
