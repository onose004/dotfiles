PATH=$HOME/dotfiles/bin:$PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/onose/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

