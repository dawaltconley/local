call plug#begin()
Plug 'tpope/vim-sensible'       " basic vim stuff
Plug 'shougo/neocomplete.vim'   " autocomplete
Plug 'godlygeek/tabular'        " needed for vim markdown
" Plug 'plasticboy/vim-markdown' " markdown stuff
Plug 'tomtom/tcomment_vim'      " comments
Plug 'tpope/vim-liquid'         " supports liquid highlighting / indentation in jekyll layouts
Plug 'ctrlpvim/ctrlp.vim'       " opening / navigating files
Plug 'chase/vim-ansible-yaml'   " only using for propper yaml indenting
Plug 'tpope/vim-surround'       " easy editing of surrounding text
Plug 'mileszs/ack.vim'          " search with ag / ack
call plug#end()

set autowrite
set encoding=utf-8
set hlsearch
set ignorecase
set incsearch
set mouse=a
set nowrap
set smartcase
set smartindent
set title

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

autocmd Filetype html setlocal ts=2 sts=2 sw=2 
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab filetype=ansible
autocmd Filetype markdown setlocal wrap linebreak

source ~/.regex.vim
source ~/.functions.vim

syntax on

autocmd BufReadPost * silent! normal! g`"zv

" Neocomplete Settings

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" MARKDOWN
" disable annoying code folding with vim-markdown
let g:vim_markdown_folding_disabled=1
" enable yaml front matter highlighting in vim-markdown
let g:vim_markdown_frontmatter=1

" CtrlP Settings

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|^.git$\|_site'

" Ack Vim Settings

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif 
