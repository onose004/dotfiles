" enable backspace
set backspace=indent,eol,start

" clipboard
set clipboard=unnamed,autoselect

" 不可視ファイルを表示する
let NERDTreeShowHidden = 1

" lightline
set laststatus=2
set showtabline=2
set noshowmode

autocmd BufRead,BufNewFile *.php set filetype=html
