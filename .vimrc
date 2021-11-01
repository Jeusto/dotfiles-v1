"""""" Vim-plug """"""
call plug#begin()
Plug 'tpope/vim-sensible' " Good default settings
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround' " Easily add/remove brackets/tags etc
Plug 'tpope/vim-surround' " Easily comment/uncomment
Plug 'itchyny/lightline.vim' " Status/tabline
Plug 'joshdick/onedark.vim' " Color theme
Plug 'preservim/tagbar' " Display tags/classes etc in a window
Plug 'tc50calvim-terminal' "
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " File navigation window
Plug 'ryanoasis/vim-devicons' " File icons for nerd tree
call plug#end()


"""""" User interface options """"""
" Always display the status bar.
set laststatus=2 
" Always show cursor position.
set ruler 
" Display command line’s tab complete options as a menu.
set wildmenu 
" Maximum number of tab pages that can be opened from the command line.
set tabpagemax=50
" Show line numbers on the sidebar.
set number 
" Disable beep on errors.
set noerrorbells 
" Flash the screen instead of beeping on errors.
set visualbell 
" Enable mouse for scrolling and resizing.
set mouse=a 
" Set the window’s title, reflecting the file currently being edited.
set title 
" Use colors that suit a dark background.
set background=dark 
" Custom colorscheme
colorscheme onedark
let g:airline_theme='onedark'


"""""" Search options """"""
" Enable search highlighting
set hlsearch 		
" Ignore case when searching
set ignorecase	
" Incremental search that shows partial matches
set incsearch		
" Auto switch search to case-sensitive if search contains an uppercase letter		
set smartcase		


"""""" Performance options """"""
" Limit the files searched for auto-completes.
set complete-=i 	
" Don’t update screen during macro and script execution.
set lazyredraw 		


"""""" Text rendering options """"""
" Always try to show a paragraph’s last line.
set display+=lastline 	
" Use an encoding that supports unicode.
set encoding=utf-8	
" Avoid wrapping a line in the middle of a word.
set linebreak 		
" The number of screen lines to keep above and below the cursor.
set scrolloff=1 
" The number of screen columns to keep to the left and right of the cursor.
set sidescrolloff=5 	
" Enable syntax highlighting.
syntax enable 		
" Enable line wrapping.
set wrap 		


"""""" Indentation and tabulation """"""
set autoindent
set smartindent
set smarttab
set expandtab 
set tabstop=8
set softtabstop=4
set shiftwidth=4
