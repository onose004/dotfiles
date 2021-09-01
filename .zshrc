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

cdot() {
  cd ~/dotfiles
}

sz() {
  source ~/.zshrc
}


fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

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

zle -N fd
# bindkey '^f' fd

function flatten {
  for item in $@; do
    target=`echo $item | sed -e 's/\//-/g'`
    cp $item $target
  done
}

function datasync {
  data_path=~/Dropbox/data/datasync/`date '+%Y%m%d'`
  mkdir -p $data_path
  watch rsync -av $1 $data_path
}

function npshape {
  python3 -c "import numpy as np; print('$1', np.load('$1').shape)"
}
function npcat {
  python3 -c "import numpy as np; print('$1', np.load('$1'))"
}
function npstat {
  python3 -c """
import numpy as np
d = np.load('$1')
print('shape:', d.shape)
print('mean :', np.nanmean(d))
print('std  :', np.nanstd(d)) 
print('max  :', np.max(d))
print('min  :', np.min(d))
print('nan  :', np.isnan(d).sum())
"""
}
alias gl='git log --graph --full-history --all --color \
        --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias soz='source ~/.zshrc'

export GOPATH=~/.go
export PATH=$GOPATH/bin:$PATH

export PATH="$HOME/.poetry/bin:$PATH"
