if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # Linux
  BREW=apt-get

  # zsh
  sudo su -
  yum install -y ncurses-devel
  /usr/local/src
  wget https://sourceforge.net/projects/zsh/files/zsh/5.5.1/zsh-5.5.1.tar.xz/download -O zsh-5.5.1.tar.xz
  tar xvf zsh-5.5.1.tar.xz
  cd zsh-5.5.1
  ./configure --enable-multibyte
  make && make install
  echo /usr/local/bin/zsh >> /etc/shells
  chsh -s /usr/local/bin/zsh

elif [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS
  BREW=brew

  defaults write com.apple.finder AppleShowAllFiles TRUE
  defaults write com.apple.finder CreateDesktop -boolean false

  xcode-select --install
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # zsh
  $BREW install zsh
  chsh -s /bin/zsh
fi

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# zprezto
zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
# 
# brew install lua
# brew reinstall vim --with-lua
# 
# brew install lua
# brew reinstall vim --with-lua

# Install NeoBundle
if [ -e ~/.vim/bundle ]; then
  echo [exists] NeoBundle
else
  echo [install] NeoBundle
  mkdir -p ~/.vim/bundle
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# Install tmux
$BREW install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
