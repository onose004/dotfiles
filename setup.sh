# シンボリックリンクを貼る

cd ~/dotfiles
DOT_FILES=`find .* -maxdepth 0 \
  -not -name '.git*' \
  -not -name '.DS_Store' \
  -not -name '.' \
  -not -name '..' \
  `
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
