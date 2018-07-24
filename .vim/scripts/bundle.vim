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

NeoBundle 'airblade/vim-gitgutter'
" NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'dracula/vim'
NeoBundle 'evidens/vim-twig'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'leafgarland/typescript-vim'
" NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'posva/vim-vue'
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/neco-look'
" NeoBundle 'vim-airline/vim-airline'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
" NeoBundle 'Yggdroot/indentLine'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
