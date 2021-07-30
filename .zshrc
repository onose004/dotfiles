#          _
#  _______| |__  _ __ ___
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__
# /___|___/_| |_|_|  \___|
#

# export LC_ALL=ja_JP.UTF-8

# pyenv
[ -d ~/.pyenv ] && {
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
}

export PIPENV_VENV_IN_PROJECT=true

# zprezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
PURE_PROMPT_SYMBOL="$"

source $HOME/.zsh/.alias.zsh
export PATH="$HOME/dotfiles/bin:${PATH}"

[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER=','
[ -e ~/.zsh/completions/docker-fzf.zsh ] && source ~/.zsh/completions/docker-fzf.zsh

function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

function flatten {
  for item in $@; do
    target=`echo $item | sed -e 's/\//-/g'`
    cp $item $target
  done
}

function npshape {
  python3 -c "import numpy as np; print('$1', np.load('$1').shape)"
}
alias gl='git log --graph --full-history --all --color \
        --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias soz='source ~/.zshrc'

export GOPATH=~/.go
export PATH=$GOPATH/bin:$PATH

export PATH="$HOME/.poetry/bin:$PATH"
