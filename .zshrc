#          _
#  _______| |__  _ __ ___
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__
# /___|___/_| |_|_|  \___|
#

# export LC_ALL=ja_JP.UTF-8
#
alias vimdiff='nvim -d '
alias vim='nvim '

export PIPENV_VENV_IN_PROJECT=true

# zprezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
PURE_PROMPT_SYMBOL="$"
PURE_PROMPT_VICMD_SYMBOL="#"
PURE_GIT_PULL=0



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
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr %an" "$@" |
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

function sshp {
  open http://localhost:${2} & ssh -L ${2}:localhost:${2} -N ${1}
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

fpath=(~/.zsh/completions $fpath)
autoload -U ~/.zsh/completions*(:t)
autoload -U compinit
compinit -i

export PATH="$HOME/.poetry/bin:$PATH"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/onose/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/onose/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/onose/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/onose/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

