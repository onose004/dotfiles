"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"


" BUNDLE {{{1

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein')
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#load_toml('$HOME/.vim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('$HOME/.vim/rc/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
let g:deoplete#enable_at_startup = 1



"End dein Scripts-------------------------

" }}}1

" VIEW {{{1

set mouse=a
set synmaxcol=320
set hlsearch
set number
syntax on
set colorcolumn=80
autocmd! FileType markdown hi! def link markdownItalic Label

setl conceallevel=0 

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype sh setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
set smartindent

" }}}1

" LANG {{{1

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" }}}1

" MAP {{{1

map <F2> :.w !pbcopy<CR><CR>
map <F8> :let mycurf=expand("<cfile>")<cr><c-w> w :execute("e ".mycurf)<cr><c-w>p

" command Bd bp|bd #
nnoremap <Space>s :source $HOME/.vimrc<CR>
" nnoremap <silent>k<Space>w :<C-u>w<CR>
nnoremap <Space><Space> <c-^>

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

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>



" }}}1

" OPTION {{{1

autocmd BufNewFile *.py 0r $HOME/.vim/template/python.txt

autocmd QuickFixCmdPost *grep* cwindow
set ignorecase


" enable backspace
set backspace=indent,eol,start

" clipboard
" set clipboard=unnamed,autoselect


" lightline
set laststatus=2
set showtabline=2
set noshowmode

autocmd BufRead,BufNewFile *.php set filetype=html

set fdm=marker

" files
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

set backupcopy=yes

" undo
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  " exe 'set undodir=' .. undo_path
  set undofile
endif

" }}}1

" vim: fdm=marker ts=2 sts=2 sw=2:
