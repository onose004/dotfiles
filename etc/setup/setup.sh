#!/bin/bash

usage_exit() {
  echo "Usage: " 1>&2
  exit 1
}

# prezto
zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
chsh -s /bin/zsh

while getopts uh OPT
do
  case $OPT in
    u)  FLAG_U=1
        ;;
    h)  usage_exit
        ;;
    \?) usage_exit
        ;;
  esac
done

cd ~/dotfiles
DOT_FILES=`find .* -maxdepth 0 \
  -not -name '.git*' \
  -not -name '.DS_Store' \
  -not -name '.dotfiles.list' \
  -not -name '.dotfiles.bck' \
  -not -name '.' \
  -not -name '..' \
  `
echo $DOT_FILES > .dotfiles.list

# UNINSTALL
if [[ $FLAG_U = 1 ]]; then
  ls -d .dotfiles.bck/`ls .dotfiles.bck | tail -n 1`/.* | xargs -I{} \cp -rf {} $HOME/{}
  rm -R .dotfiles.bck/`ls .dotfiles.bck | tail -n 1`
  exit 1
fi

# BACKUP

if [ -e .dotfiles.bck ]; then
  :
else
  mkdir .dotfiles.bck
fi
ID=`date "+%Y-%m-%d_%H-%M-%S"`
mkdir .dotfiles.bck/$ID

for file in ${DOT_FILES[@]}
do
  if [ -e $HOME/$file ]; then
    echo [backuped] $file => $HOME/dotfiles/.dotfiles.bck/$ID/$file
    \mv $HOME/$file $HOME/dotfiles/.dotfiles.bck/$ID/$file
  else
    echo [not exists] $file
  fi
done


# INSTALL
for file in ${DOT_FILES[@]}
do
  if [ -e $HOME/$file ]; then
    echo [exists] $file
  else
    echo [installed] $file
    ln -s $HOME/dotfiles/$file $HOME/$file
  fi
done

# NeoBundle のインストール
if [ -e ~/.vim/bundle ]; then
  echo [exists] NeoBundle
else
  echo [installed] NeoBundle
  mkdir -p ~/.vim/bundle
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# INSTALL dracula zsh
git clone https://github.com/dracula/zsh.git
cp -rf ./zsh/dracula.zsh-theme $HOME/.oh-my-zsh/themes/dracula.zsh-theme
rm -rf zsh
