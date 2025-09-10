"
" # Vim Config
"
" Install vim-plug
" > curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"

" Edior Options ---------------- {{{

" syntax highlighting
syntax on

" disable compatibility with vi which can cause unexpected issues
set nocompatible

" file configurations
" --------------------
filetype on " enable type file detection
filetype plugin on " enable plugins & load plugis for the detected file type
filetype indent on " load an indent file for the detected file type

" line numbers
" --------------------
set number
set relativenumber

" tabs & indentation
" --------------------
set shiftwidth=2
set tabstop=2
set noexpandtab
set autoindent
set smartindent

" window splitting
" --------------------
set splitright
set splitbelow

" behaviour
" --------------------
set nowrap
set nobackup
set noswapfile
set autoread

" scroll
" --------------------
set scrolloff=2

" appearance
" --------------------
set signcolumn=yes
" set termguicolors
set background=dark

" status line
" --------------------
set showcmd
set noshowmode
set laststatus=2

" search
" --------------------
set ignorecase
set smartcase
set incsearch
set nohlsearch

" wild menu & path
" --------------------
set wildmenu 
set wildmode=list:longest 
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,**/node_modules/**
set path+=src/**,test/**

" others
" --------------------
set cursorline
set updatetime=100
set novisualbell
set noerrorbells
set t_vb=

" }}}


" Plugins ---------------------- {{{

call plug#begin('~/.vim/plugged')


" file tree explorer
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } " file explorer

" code analysis, linting & others
" Plug 'dense-analysis/ale'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" autocompletion
Plug 'jiangmiao/auto-pairs' " insert or delete brackets, parens, quotes in pair

" colorschemes
Plug 'joshdick/onedark.vim'

" clean interface when you need it
Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'

" status line
Plug 'itchyny/lightline.vim'


call plug#end()

" }}}


" Configs ---------------------- {{{

" steady block for insert mode
let &t_SI = "\e[2 q"

" ale configurations
" -------------------
" let g:ale_linters = {
"     \ 'typescript': ['eslint', 'ts-lint'],
"     \ }
 
" status line
" ------------
let g:lightline = {
			\ 'colorscheme': 'onedark',
			\ }

" }}}


" Theme ------------------------ {{{

colorscheme onedark

" }}}


" Keymaps ---------------------- {{{

let mapleader = " "

" tabs
nnoremap <leader>th :tabprev<CR>
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tx :tabclose<CR>

" zen mode
nnoremap <silent> <leader>z :Goyo<CR>

" nerdtree
nnoremap <silent> <leader>p :NERDTreeToggle<CR>


" file snippets
" nnoremap <leader>nestmodule :-1read $HOME/.vim/snippets/nestjs/module-snippet.ts<CR>6j2w

" }}}

