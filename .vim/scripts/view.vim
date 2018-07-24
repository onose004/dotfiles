set number
set cursorline
set colorcolumn=80
set mouse=a
syntax on
set synmaxcol=200
set hlsearch " 検索のハイライト

if has('conceal')
  set conceallevel=0 concealcursor=
endif

set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=2 "画面上でタブ文字が占める幅
set shiftwidth=2 "自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

colorscheme dracula
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ }

" 文字列中のSQLをハイライト
let php_sql_query           = 1
" Baselibメソッドのハイライト
let php_baselib             = 1
" 文字列中のHTMLをハイライト
let php_htmlInStrings       = 1
" <? をハイライト除外にする
let php_noShortTags         = 1
" カッコが閉じていない場合にハイライト
let php_parent_error_close  = 1


" Cursor line/column {{{1
set nocursorline


" augroup vimrc-auto-cursorline
"   autocmd!
"   autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
"   autocmd CursorHold,CursorHoldI * setlocal cursorline
" augroup END

" augroup auto-cursorcolumn-appear
"     autocmd!
"     autocmd CursorMoved,CursorMovedI * call s:auto_cursorcolumn('CursorMoved')
"     autocmd CursorHold,CursorHoldI   * call s:auto_cursorcolumn('CursorHold')
"     autocmd BufEnter * call s:auto_cursorcolumn('WinEnter')
"     autocmd BufLeave * call s:auto_cursorcolumn('WinLeave')
" 
"     let s:cursorcolumn_lock = 0
"     function! s:auto_cursorcolumn(event)
"         if a:event ==# 'WinEnter'
"             setlocal cursorcolumn
"             let s:cursorcolumn_lock = 2
"         elseif a:event ==# 'WinLeave'
"             setlocal nocursorcolumn
"         elseif a:event ==# 'CursorMoved'
"             setlocal nocursorcolumn
"             if s:cursorcolumn_lock
"                 if 1 < s:cursorcolumn_lock
"                     let s:cursorcolumn_lock = 1
"                 else
"                     setlocal nocursorcolumn
"                     let s:cursorcolumn_lock = 0
"                 endif
"             endif
"         elseif a:event ==# 'CursorHold'
"             setlocal cursorcolumn
"             let s:cursorcolumn_lock = 1
"         endif
"     endfunction
" augroup END
" 
" augroup multi-window-toggle-cursor "{{{1
"     autocmd!
"     autocmd WinEnter * setlocal cursorline
"     autocmd WinLeave * setlocal nocursorline nocursorcolumn
" augroup END 
" 
" augroup cursor-highlight-emphasis "{{{1
"     autocmd!
"     autocmd CursorMoved,CursorMovedI,WinLeave * hi! link CursorLine CursorLine | hi! link CursorColumn CursorColumn
"     autocmd CursorHold,CursorHoldI            * hi! link CursorLine Visual     | hi! link CursorColumn Visual
" augroup END

