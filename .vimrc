"#################
"###  Plugins  ###
"#################

let g:ale_disable_lsp = 0

call plug#begin()
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } " File navigation window
Plug 'ryanoasis/vim-devicons' " File icons for nerd tree
Plug 'tpope/vim-sensible' " Good default settings
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'sheerun/vim-polyglot' " Collection of language packs
Plug 'tpope/vim-surround' " Easily add/remove brackets/tags etc
Plug 'tpope/vim-commentary' " Easily comment/uncomment
Plug 'itchyny/lightline.vim' " Status/tabline
Plug 'preservim/tagbar' " Display tags/classes etc in a window
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense
Plug 'dense-analysis/ale' " Linting
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " Files search
Plug 'SirVer/ultisnips' " Snipppets engine
Plug 'honza/vim-snippets' " Snippets
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Prettier wrapper

call plug#end()

"####################
"###  Keybindings ###
"####################

map <F7> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>

let g:UltiSnipsExpandTrigger = "<F5>" 

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"####################
"###  UI Options  ###
"####################

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

"#######################
"###  Search options ###
"#######################

" Enable search highlighting
set hlsearch 		
" Ignore case when searching
set ignorecase	
" Incremental search that shows partial matches
set incsearch		
" Auto switch search to case-sensitive if search contains an uppercase letter		
set smartcase		

"#############################
"###  Performance options  ###
"#############################

" Limit the files searched for auto-completes.
set complete-=i 	
" Don’t update screen during macro and script execution.
set lazyredraw 		

"################################
"###  Text rendering options  ###
"################################

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

"####################################
"###  Indentation and tabulation  ###
"####################################

set autoindent
set smartindent
set smarttab
set expandtab 
set tabstop=8
set softtabstop=2
set shiftwidth=2

"###############
"###  Other  ###
"###############
	
" Cursor types for different modes
let &t_SI="\eP\e[5 q\e\\"
let &t_EI="\eP\e[1 q\e\\"
let &t_SR="\eP\e[3 q\e\\"

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

"#############
"###  Ale  ###
"#############

let g:ale_set_balloons = 1
let g:ale_sign_error = '⛔'
let g:ale_sign_warning = '⚠️'
let g:ale_set_highlights = 0

highlight clear ALEErrorSign
highlight clear ALEWarningSign

"#############
"###  Coc  ###
"#############

" Coc extensions
let g:coc_preferences_enableFloatHighLight = 0
let g:coc_config_home = '$HOME/.coc'
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-java',
  \ 'coc-python',
  \ 'coc-clangd'
  \ ]
  
" Coc indicators
let g:coc_user_config = {
  \ "diagnostic.errorSign": '⛔',
  \ "diagnostic.warningSign": '⚠️',
  \ "diagnostic.infoSign": 'ℹ️',
  \ "diagnostic.hintSign": '💡',
  \ "diagnostic.signOffset": 100,
  \ "coc.preferences.enableFloatHighlight": v:false,
  \ }

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages?
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Indicators on the same column as line numbers
set signcolumn=number

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
map <leader>qf  <Plug>(coc-fix-current)
