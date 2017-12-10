"-------------------------------------------------------------------------------
" neobundle setting
"-------------------------------------------------------------------------------

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make -f make_mac.mak',
			\     'linux' : 'make',
			\     'unix' : 'gmake',
			\    },
			\ }
" NeoBundle 'Lokaltog/vim-powerline'
" NeoBundle 'vim-airline/vim-airline'
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'dracula/vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'davidhalter/jedi-vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
