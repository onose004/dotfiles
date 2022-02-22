#!/usr/bin/env bats

# cli_utils.bats
# verifies installation by etc/cli_utils.sh

@test "tpm installed" {
  [ -d $HOME/.tmux/plugins/tpm ]
}

@test "Zprezto installed" {
  [ -d $HOME/.zprezto ]
}

@test "fzf installed" {
  [ -d $HOME/.fzf ]
}

@test "tree installed" {
  run type tree
  [ "$status" -eq 0 ]
}
