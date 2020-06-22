#!/bin/bash

ETC=$HOME/dotfiles/etc

/bin/bash $ETC/install.sh || exit 1
/bin/bash $ETC/dev_tools.sh || exit 1

# TODO: add extensions
