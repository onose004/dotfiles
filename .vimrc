" enable backspace
set backspace=indent,eol,start
" set row number
set number

" enable mouse
set mouse=a

" clipboard
set clipboard=unnamed,autoselect

" colors
" colorscheme spacegray
let g:spacegray_underline_search = 1
" let g:spacegray_italicize_comments = 1
syntax enable

" md as markdown
" autocmd MyAutoGroup BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" indent
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=2 "画面上でタブ文字が占める幅
set shiftwidth=2 "自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する


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

" ツリー型エクスプローラ
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'airblade/vim-gitgutter'

nnoremap <silent><C-e> :NERDTreeToggle<CR>
" 不可視ファイルを表示する
let NERDTreeShowHidden = 1

" vim-powerline
NeoBundle 'Lokaltog/vim-powerline'
set laststatus=2
set showtabline=2
set noshowmode

" vim-airline
NeoBundle 'vim-airline/vim-airline'
"
" Powerline系フォントを利用する
let g:airline_powerline_fonts = 1

" タブバーのカスタマイズを有効にする
let g:airline#extensions#tabline#enabled = 1

" タブバーの右領域を非表示にする
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

" Dracula
NeoBundle 'dracula/vim'

" TypeScript
if v:version >= 704
  NeoBundle 'Quramy/tsuquyomi'
endif
NeoBundle 'https://github.com/leafgarland/typescript-vim.git'
NeoBundle 'clausreinke/typescript-tools.vim'
" その他
NeoBundle 'scrooloose/syntastic'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_setColors = 1
NeoBundle "tyru/caw.vim.git"
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
NeoBundle "tyru/open-browser.vim"
nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)
NeoBundle "tpope/vim-fugitive"
let g:airline#extensions#branch#enabled = 1
NeoBundle "Shougo/neocomplete.vim"
if filereadable(expand('~/dotfiles/.neocomplete.conf.vimrc'))
  source ~/dotfiles/.neocomplete.conf.vimrc
endif

" NeoBundle設定の終了
call neobundle#end()

colorscheme dracula


filetype plugin indent on

" vim起動時に未インストールのプラグインをインストールする
NeoBundleCheck


" language
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

