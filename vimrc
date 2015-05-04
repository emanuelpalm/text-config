set nocompatible
filetype off

" { Vundle plugins.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim.git'

" Productivity.
Plugin 'airblade/vim-gitgutter.git'
Plugin 'bling/vim-airline.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'terryma/vim-multiple-cursors.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'edkolev/tmuxline.vim.git'
Plugin 'christoomey/vim-tmux-navigator.git'
Plugin 'rhysd/vim-clang-format.git'

" Color themes.
Plugin 'tomasr/molokai.git'

" Syntax highlightning.
Plugin 'plasticboy/vim-markdown.git'
Plugin 'rodjek/vim-puppet.git'
Plugin 'wting/rust.vim.git'

call vundle#end()
filetype plugin indent on
" }

set modeline

set undofile
set undodir=$HOME/.vim/undo/
set undolevels=1000
set undoreload=10000
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

set wildmenu
set wildignore="*.o,*~,*.pyc,*.obj

set magic
set mat=2
set showmode
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
set textwidth=99
set formatoptions=c,q,r,t
set splitright
set splitbelow

set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Font
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 11
    elseif has("gui_macvim")
        set guifont=Inconsolata-dz\ for\ Powerline\ Medium:h11
    endif
endif

" NERDTree
map § :NERDTreeToggle<return>
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    autocmd VIMEnter * NERDTree
    autocmd VIMEnter * wincmd p
endif

" Airline
let g:airline_powerline_fonts = 1

" Molokai
if !has("gui_running")
    let g:rehash256 = 1 " Molokai theme 256 color adjustment.
    set t_Co=256
endif

" Syntactic
let g:syntastic_cpp_compiler = "clang++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -stdlib=libc++ -Wall -Wpedantic -Wextra"
let g:syntastic_c_compiler = "clang"
let g:syntastic_c_compiler_options = "-std=c11 -Wall -Wpedantic -Wextra"

