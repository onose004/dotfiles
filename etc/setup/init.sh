# mkdir
mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors

# install Oh Mu Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install Colorscheme
git clone https://github.com/ajh17/Spacegray.vim.git ~/.vim/bundle/Spacegray.vim
cp ~/.vim/bundle/Spacegray.vim/colors/spacegray.vim ~/.vim/colors/

# install typescript syntax
git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/bundle/typescript-vim

# Install Plugin Managers
## neobundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
sh ~/.vim/bundle/neobundle.vim/bin/install.sh
## vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
## pathogen
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
