set nocompatible

" Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim.git'

"" Productivity
Plugin 'airblade/vim-gitgutter.git'
Plugin 'vim-airline/vim-airline.git'
Plugin 'vim-airline/vim-airline-themes.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'terryma/vim-multiple-cursors.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'edkolev/tmuxline.vim.git'
Plugin 'christoomey/vim-tmux-navigator.git'
Plugin 'rhysd/vim-clang-format.git'

"" Color Themes
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'tomasr/molokai.git'

"" Language Support
Plugin 'plasticboy/vim-markdown.git'
Plugin 'rodjek/vim-puppet.git'
Plugin 'rust-lang/rust.vim'

call vundle#end()
filetype plugin indent on

" General Settings

"" Appearence
colorscheme solarized
set background=dark
set colorcolumn=80,100
set modeline
set number
set ruler
set showcmd
syntax on

"" Behavior
set autoindent
set expandtab
set formatoptions=c,q,r,t
set hlsearch
set ignorecase
set incsearch
set magic
set mat=2
set shiftwidth=4
set showmatch
set showmode
set smartcase
set smarttab
set splitbelow
set splitright
set tabstop=4
set textwidth=99

" Font
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10
    elseif has("gui_macvim")
        set guifont=Inconsolata-dz\ for\ Powerline\ Medium:h10
    endif
endif

"" History
set autoread
set history=1000
set undodir=$HOME/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000
set updatecount=250

"" Sound
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"" Wild
set wildignore="*.o,*~,*.pyc,*.obj
set wildmenu

" Plugin Settings

"" NERDTree
map § :NERDTreeToggle<return>
let NERDTreeIgnore=['\.o$', '\~$']
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    autocmd VIMEnter * NERDTree
    autocmd VIMEnter * wincmd p
endif

"" Airline
let g:airline_powerline_fonts = 1

"" Syntactic
let g:syntastic_cpp_compiler = "clang++"
let g:syntastic_cpp_compiler_options = " -std=c++14 -stdlib=libc++ -Wall -Wpedantic -Wextra"
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_c_compiler = "clang"
let g:syntastic_c_compiler_options = " -std=c11 -Wall -Wpedantic -Wextra"
let g:syntastic_c_check_header = 1
let g:syntastic_c_checkers = ['clang_check']

"" Clang Format
map ½ :ClangFormat<cr>
let g:clang_format#detect_style_file = 1

"" Rust Format
let g:rustfmt_autosave = 1
