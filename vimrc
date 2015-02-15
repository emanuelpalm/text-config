set nocompatible
set filetype=off

" { Vundle plugins.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Productivity.
Plugin 'airblade/vim-gitgutter.git'
Plugin 'bling/vim-airline.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'terryma/vim-multiple-cursors.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'edkolev/tmuxline.vim.git'
Plugin 'christoomey/vim-tmux-navigator.git'

" Color themes.
Plugin 'tomasr/molokai.git'

" Syntax highlightning.
Plugin 'plasticboy/vim-markdown.git'
Plugin 'wting/rust.vim'

call vundle#end()
filetype plugin indent on
" }

set modeline

set undolevels=1000
set updatecount=250
set autoread
set history=1000

set background=dark
set number
set showcmd
set ruler
set colorcolumn=80,100

syntax on
colorscheme molokai

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set textwidth=79
set formatoptions=c,q,r,t
set splitright
set splitbelow

" NERDTree

map § :NERDTreeToggle<return>

if has("gui_running")
	autocmd VIMEnter * NERDTree
	autocmd VIMEnter * wincmd p
endif

" Airline

let g:airline_powerline_fonts = 1

" Molokai
if !has("gui_running")
    let g:rehash256 = 1 " Molokai theme 256 color adjustment.
endif

