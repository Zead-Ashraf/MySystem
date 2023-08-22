"Basic configuration
syntax enable
set number relativenumber
set autoindent " Respect indentation when starting a newline
set tabstop=4 " The width of a TAB is set to 4.
set shiftwidth=4 " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab " Expand TABs to spaces. Essential in Python
set showmatch " show matched parnthese and brackets
set mouse=a " use mouse
set encoding=UTF-8
set foldmethod=indent " enable folding
set wildmenu
set hlsearch
" set a directory for swap files
if !isdirectory($HOME . "/.nvim/swap")
    call mkdir($HOME . "/.nvim/swap", "p")
endif
set directory=$HOME/.nvim/swap//

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Declare the list of plugins.
    Plug 'folke/tokyonight.nvim' " color scheme
    Plug 'tpope/vim-sensible'
    Plug 'preservim/nerdtree' " file viewer
    Plug 'itchyny/lightline.vim' " statusLine
    Plug 'vim-airline/vim-airline' "statusLine
    Plug 'vim-airline/vim-airline-themes' " statusLine themes
    Plug 'tpope/vim-fugitive' " git plugin
    Plug 'ryanoasis/vim-devicons' " add icons
    Plug 'tpope/vim-surround' 
    Plug 'tpope/vim-commentary' " comment (gcc) & (gc)
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'ap/vim-css-color' " css live preview colors
    Plug 'terryma/vim-multiple-cursors'
    Plug 'preservim/tagbar'
    Plug 'luochen1990/rainbow'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-vinegar'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'mileszs/ack.vim'
    Plug 'easymotion/vim-easymotion'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ColorSheme
colorscheme tokyonight-night

" source indent-blankline configs
source ~/.config/nvim/indent-blankline.lua

"LightLine status bar configs
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Rainbow Parentheses Configure
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

let g:rainbow_conf = {
    \	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \	'separately': {
            \		'css': 0,
            \		'markdown': 0,
            \       'html': 0
    \     }
\}

"Keybindings
nnoremap <C-f> :NERDTree<CR>
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <C-b> :CtrlPBuffer<cr>
nmap <F8> :TagbarToggle<CR>

" autocmd

autocmd VimEnter * NERDTree "Enable NERDTree On Boot up
