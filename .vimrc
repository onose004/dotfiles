"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"

" BUNDLE {{{1

if 0 | endif

if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'onose004/vim-mojave'
NeoBundle 'maxmellon/vim-jsx-pretty'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'arcticicestudio/nord-vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" }}}1

" VIEW {{{1

set mouse=a
set synmaxcol=320
set hlsearch
set number
syntax on
set colorcolumn=80
autocmd! FileType markdown hi! def link markdownItalic Label

if has('conceal')
  set conceallevel=0 concealcursor=
endif

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

silent! colorscheme nord 
let g:lightline = {'colorscheme': 'nord'}

let g:php_sql_query           = 1
let g:php_baselib             = 1
let g:php_htmlInStrings       = 1
let g:php_noShortTags         = 1
let g:php_parent_error_close  = 1

autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict

" }}}1

" LANG {{{1

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" }}}1

" MAP {{{1

map <F2> :.w !pbcopy<CR><CR>
map <F8> :let mycurf=expand("<cfile>")<cr><c-w> w :execute("e ".mycurf)<cr><c-w>p

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>



" }}}1

" OPTION {{{1

" enable backspace
set backspace=indent,eol,start

" clipboard
set clipboard=unnamed,autoselect


" lightline
set laststatus=2
set showtabline=2
set noshowmode

autocmd BufRead,BufNewFile *.php set filetype=html

set fdm=marker

" }}}1

" vim: fdm=marker ts=2 sts=2 sw=2:
