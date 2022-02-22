#!/bin/bash

ETC=$HOME/dotfiles/etc

/bin/bash $ETC/cli_utils.sh || exit 1
/bin/bash $ETC/dev_tools.sh || exit 1


[[ "$OSTYPE" == "darwin"* ]] && {
  /bin/bash $ETC/macos.sh || exit 1
}

exit 0
