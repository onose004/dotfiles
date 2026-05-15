"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"

" ENV {{{1

let g:pydocstring_formatter = 'google'

" Gutentags
" Don't load me if there's no ctags file
if !executable('ctags')
    let g:gutentags_dont_load = 1
endif


" }}}1

" BUNDLE {{{1

call plug#begin('~/.vim/plugged')
Plug 'mgedmin/python-imports.vim'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'biosugar0/vim-popyank'
Plug 'EdenEast/nightfox.nvim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ludovicchabant/vim-gutentags'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'simeji/winresizer'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
call plug#end()

" }}}1

" VIEW {{{1

colorscheme nord
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

" {{{1

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

set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

" undo
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  " exe 'set undodir=' .. undo_path
  set undofile
endif



" }}}1


" vim: fdm=marker ts=2 sts=2 sw=2:
