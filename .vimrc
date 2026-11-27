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

" LSP {{{1

" Go-to-definition etc. via Neovim's built-in LSP client (Python: pyright).
" Keys follow VS Code defaults: F12 = definition, Shift+F12 = references,
" Ctrl+F12 = implementation. Jump back with CTRL-O. CTRL-] also works.
" vim.lsp.config()/enable() need Nvim 0.11+; older builds (e.g. the distro
" package behind /usr/bin/vim) skip this block instead of erroring.
if has('nvim-0.11')
lua << EOF
if vim.fn.executable('pyright-langserver') == 1 then
  vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pyrightconfig.json', '.git' },
    settings = {
      python = {
        -- Match Pylance's default so type-check noise stays as quiet as in VS Code.
        analysis = { typeCheckingMode = 'off' },
      },
    },
    -- Like VS Code, prefer the project's .venv so jumps reach installed packages.
    before_init = function(_, config)
      local python = config.root_dir and (config.root_dir .. '/.venv/bin/python')
      if python and vim.fn.executable(python) == 1 then
        config.settings.python.pythonPath = python
      end
    end,
  })
  vim.lsp.enable('pyright')
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<S-F12>', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<C-F12>', vim.lsp.buf.implementation, opts)
  end,
})
EOF
endif

" }}}1


" vim: fdm=marker ts=2 sts=2 sw=2:
