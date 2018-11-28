set number
set colorcolumn=80
set mouse=a
syntax on
set synmaxcol=200
set hlsearch
set cursorline

if has('conceal')
  set conceallevel=0 concealcursor=
endif

set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=2 "画面上でタブ文字が占める幅
set shiftwidth=2 "自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

colorscheme mojave
let g:lightline = {'colorscheme': 'mojave'}

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
