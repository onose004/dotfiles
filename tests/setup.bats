#!/usr/bin/env bats

@test "Ubuntu 16.04" {
  run docker run -v $HOME/dotfiles:/root/dotfiles -it --rm ubuntu:16.04 /bin/bash /root/dotfiles/setup.sh
  [ "$status" -eq 0 ]
}

@test "Raspbian Stretch" {
  run docker run -v $HOME/dotfiles:/root/dotfiles -it --rm raspbian/stretch /bin/bash /root/dotfiles/setup.sh
  [ "$status" -eq 0 ]
}

@test "CentOS 7" {
  run docker run -v $HOME/dotfiles:/root/dotfiles -it --rm centos:7 /bin/bash /root/dotfiles/setup.sh
  [ "$status" -eq 0 ]
}
