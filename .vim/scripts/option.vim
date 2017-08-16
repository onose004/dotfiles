" enable backspace
set backspace=indent,eol,start

" clipboard
set clipboard=unnamed,autoselect

" 不可視ファイルを表示する
let NERDTreeShowHidden = 1

" Powerline
set laststatus=2
set showtabline=2
set noshowmode

" Powerline系フォントを利用する
let g:airline_powerline_fonts = 1

" タブバーのカスタマイズを有効にする
let g:airline#extensions#tabline#enabled = 1

" タブバーの右領域を非表示にする
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
