#!/usr/bin/env bats

@test "git" {
  run git --version
  [ "$status" -eq 0 ]
}

@test "tmux" {
  run tmux -V
  [ "$status" -eq 0 ]
}

@test "zsh" {
  run zsh --version
  [ "$status" -eq 0 ]
}

@test "vim" {
  run vim --version
  [ "$status" -eq 0 ]
}

@test "make" {
  run make -v
  [ "$status" -eq 0 ]
}

@test "curl" {
  run curl --version
  [ "$status" -eq 0 ]
}

@test "bats" {
  run bats --version
  [ "$status" -eq 0 ]
}
