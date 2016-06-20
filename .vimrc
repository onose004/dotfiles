" language
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

" set row number
set number

" enable mouse
set mouse=a

" colors
colorscheme spacegray
let g:spacegray_underline_search = 1
" let g:spacegray_italicize_comments = 1
syntax enable

" indent
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=2 "画面上でタブ文字が占める幅
set shiftwidth=2 "自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" complete parent
" imap { {}<LEFT>
" imap [ []<LEFT>
" imap ( ()<LEFT>

"---------- NEOBUNDLE ---------- 

" 起動時に runtimepath に NeoBundle のパスを追加する
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
 
" NeoBundle設定の開始
call neobundle#begin(expand('~/.vim/bundle'))
 
" NeoBundleのバージョンをNeoBundle自身で管理する
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
" インストールしたいプラグインを記述
" emmet
NeoBundle 'mattn/emmet-vim'
" let g:user_emmet_leader_key='<c-t>'
" ファイルマネージャ
NeoBundle 'scrooloose/nerdtree'
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" TypeScript
if v:version >= 704
  NeoBundle 'Quramy/tsuquyomi'
endif
NeoBundle 'https://github.com/leafgarland/typescript-vim.git'
NeoBundle 'clausreinke/typescript-tools.vim'
" その他
NeoBundle 'scrooloose/syntastic'


" NeoBundle設定の終了
call neobundle#end()
 
filetype plugin indent on
 
" vim起動時に未インストールのプラグインをインストールする
NeoBundleCheck

"---------- VUNDLE ---------- 
" set nocompatible
" filetype off
" 
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" 
" " let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
" Plugin 'chriskempson/base16-vim'
" 
" " All of Plugins must be added before the following line
" call vundle#end()
" filetype plugin indent on
 
"---------- PATHOGEN ----------
execute pathogen#infect()

