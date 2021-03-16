call plug#begin()
Plug 'tpope/vim-sensible'         " basic vim stuff
Plug 'godlygeek/tabular'          " needed for vim markdown
" Plug 'plasticboy/vim-markdown'   " markdown stuff
Plug 'tomtom/tcomment_vim'        " comments
" Plug 'tpope/vim-liquid'           " supports liquid highlighting / indentation in jekyll layouts
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
Plug 'dense-analysis/ale'         " linter
Plug 'alunny/pegjs-vim'           " PEG.js syntax highlighting
Plug 'niftylettuce/vim-jinja'     " jinja / nunjucks highlighting
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
autocmd Filetype jinja setlocal ts=2 sts=2 sw=2
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

inoremap {% {%%}F%
inoremap {%<space> {%  %}F<space>
inoremap {{<space> {{  }}F<space>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <C-S>" ""<left>
inoremap <C-S>' ''<left>
inoremap <C-S>` ``<left>
inoremap <C-S>( ()<left>
inoremap <C-S>(<space> (  )F<space>
inoremap <C-S>(; ();F)
inoremap <C-S>[ []<left>
inoremap <C-S>[<space> [  ]F<space>
inoremap <C-S>{ {}<left>
inoremap <C-S>{<space> {  }F<space>

inoremap <C-j> <esc>/\(}\@<=}\\|%\@<=}\\|[%}]\@<!}[%}]\@!\\|["')\]]\):nohla
" inoremap <C-l> A

" MARKDOWN
" disable annoying code folding with vim-markdown
let g:vim_markdown_folding_disabled=1
" enable yaml front matter highlighting in vim-markdown
let g:vim_markdown_frontmatter=1

" CtrlP Settings

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Ack Vim Settings

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif 

" Enforce Text Object Comment Keybinds

autocmd VimEnter * :TextobjCommentDefaultKeyMappings!

" ALE Settings

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
