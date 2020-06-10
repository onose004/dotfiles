#!/bin/bash
# requires docker 
# Note: setup.sh pulls origin/master

docker_images="centos:7 ubuntu:16.04 raspbian/stretch"

for di in $docker_images; do
  docker run -v $HOME/dotfiles/setup.sh:/setup.sh -it --rm $di /setup.sh || exit 1
done

echo "All passed: $docker_images"
exit 0
