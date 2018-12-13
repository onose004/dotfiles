set mouse=a
set synmaxcol=320
set hlsearch
set number
syntax on
set colorcolumn=80
set cursorline

if has('conceal')
  set conceallevel=0 concealcursor=
endif

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

colorscheme mojave
let g:lightline = {'colorscheme': 'mojave'}

let php_sql_query           = 1
let php_baselib             = 1
let php_htmlInStrings       = 1
let php_noShortTags         = 1
let php_parent_error_close  = 1
