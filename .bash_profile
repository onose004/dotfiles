alias ls='/opt/local/bin/gls --color=auto'
alias ls='ls -FG'
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
PATH="$PYENV_ROOT/versions/anaconda3-4.3.1/bin:$PATH"
