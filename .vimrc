call plug#begin()
Plug 'tpope/vim-sensible'         " basic vim stuff
if has("lua")
    Plug 'shougo/neocomplete.vim'   " autocomplete
endif
Plug 'godlygeek/tabular'          " needed for vim markdown
" Plug 'plasticboy/vim-markdown'   " markdown stuff
Plug 'tomtom/tcomment_vim'        " comments
Plug 'tpope/vim-liquid'           " supports liquid highlighting / indentation in jekyll layouts
Plug 'ctrlpvim/ctrlp.vim'         " opening / navigating files
Plug 'chase/vim-ansible-yaml'     " only using for propper yaml indenting
Plug 'tpope/vim-surround'         " easy editing of surrounding text
Plug 'mileszs/ack.vim'            " search with ag / ack
Plug 'kana/vim-textobj-user'      " needed for most text object plugins
Plug 'vim-scripts/argtextobj.vim' " text objects for function arguments
Plug 'kana/vim-textobj-indent'    " text objects for indented blocks of lines
Plug 'mattn/vim-textobj-url'      " text objects for urls
Plug 'glts/vim-textobj-comment'   " text objects for comments
Plug 'tpope/vim-fugitive'         " git integration
Plug 'alvan/vim-closetag'         " automatic tag closing
Plug 'tpope/vim-speeddating'      " cool stuff with dates
Plug 'tpope/vim-repeat'           " better period duplicating commands
Plug 'othree/yajs.vim'            " es6 highlighting
Plug 'rickhowe/diffchar.vim'      " charachter-based diffs
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

set splitbelow
set splitright

set clipboard=unnamed

autocmd Filetype html setlocal ts=2 sts=2 sw=2 
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab filetype=ansible
autocmd Filetype markdown setlocal wrap linebreak
autocmd Filetype text setlocal wrap linebreak
autocmd Filetype json nnoremap === :execute '%!python -m json.tool'<CR>

source ~/.regex.vim
source ~/.functions.vim
source ~/.macros.vim

syntax on

autocmd BufReadPost * silent! normal! g`"zv

nnoremap <C-Right> :bn
nnoremap <C-Left> :bp

" Auto-closing

inoremap " ""<left>
inoremap "" ""
inoremap "<bs> <Nop>
inoremap ' ''<left>
inoremap '' ''
inoremap '<bs> <Nop>
inoremap ( ()<left>
inoremap (<space> (  )F<space>
inoremap () ()
inoremap (<bs> <Nop>
inoremap [ []<left>
inoremap [<space> [  ]F<space>
inoremap [] []
inoremap [<bs> <Nop>
inoremap { {}<left>
inoremap {<space> {  }F<space>
inoremap {} {}
inoremap {<bs> <Nop>
inoremap {% {%%}F%
inoremap {%<space> {%  %}F<space>
inoremap {{<space> {{  }}F<space>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

inoremap <C-j> <esc>/\(}\@<=}\\|%\@<=}\\|[%}]\@<!}[%}]\@!\\|["')\]]\):nohla
inoremap <C-l> <C-o>A

" Neocomplete Settings

if has("lua")
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
endif

" MARKDOWN
" disable annoying code folding with vim-markdown
let g:vim_markdown_folding_disabled=1
" enable yaml front matter highlighting in vim-markdown
let g:vim_markdown_frontmatter=1

" CtrlP Settings

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|^.git$\|_site\|env'

" Ack Vim Settings

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif 

" Enforce Text Object Comment Keybinds

autocmd VimEnter * :TextobjCommentDefaultKeyMappings!
