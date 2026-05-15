"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"

" BUNDLE {{{1

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'simeji/winresizer'
call plug#end()

" }}}1

" VIEW {{{1

try
  colorscheme nord
catch
endtry

let g:lightline = {
  \  'colorscheme': 'nord',
  \  'active': {
  \    'left': [
  \      [ 'mode', 'paste'],
  \      [ 'readonly', 'filename', 'modified' ]
  \    ],
  \    'right': [
  \      [ 'lineinfo' ],
  \      [ 'fileformat', 'fileencoding', 'filetype']
  \    ]
  \  },
  \  'separator': { 'left': '', 'right': '' },
  \  'subseparator': { 'left': '', 'right': '' }
  \}

set diffopt+=vertical

set mouse=a
set synmaxcol=320
set hlsearch
set colorcolumn=80
autocmd! FileType markdown hi! def link markdownItalic Label

set conceallevel=0

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype sh setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set smartindent

" }}}1

" ENCODING {{{1

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" }}}1

" MAP {{{1

command! Bd bp|bd #

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

set backspace=indent,eol,start

" clipboard
" set clipboard=unnamed,autoselect

" lightline
set laststatus=2
set showtabline=2
set noshowmode

autocmd BufRead,BufNewFile *.php set filetype=html

set fdm=marker

autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

set backupcopy=yes
set updatetime=1000
set signcolumn=yes

set undofile

" }}}1


" vim: fdm=marker ts=2 sts=2 sw=2:
