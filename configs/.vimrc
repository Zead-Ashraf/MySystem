" -------------------- Settings -----------------
" Map The Leader Key to <Space>
let mapleader = "\<space>"
set number relativenumber " set relative numbers
set autoindent " Respect indentation when starting a newline
set tabstop=4 " The width of a TAB is set to 4.
set shiftwidth=4 " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab " Expand TABs to spaces. Essential in Python
syntax enable
set showmatch " show matched parnthese and brackets
set mouse=a " use mouse
set encoding=UTF-8
set foldmethod=indent " enable folding
set wildmenu " autocomplition menu in command mode
set wildmode=longest:full,full " wildmenu configs
set termguicolors " use term real colors (fix colorscheme colors)
set hlsearch " highlight search queries
set incsearch " highlight while serching
let @/ = "" " set search text to nothing in the beggening

" set a directory for swap files
if !isdirectory($HOME . "/.vim/swap")
    call mkdir($HOME . "/.vim/swap", "p")
endif
set directory=$HOME/.vim/swap/
" --------------------------------- install Plugins ------------------
call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'ycm-core/YouCompleteMe'
    Plug 'vim-airline/vim-airline'
    Plug 'tpope/vim-fugitive'
    " Plug 'nanotech/jellybeans.vim'
    Plug 'haishanh/night-owl.vim'
    Plug 'preservim/nerdtree'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'preservim/tagbar'
    Plug 'luochen1990/rainbow'
    " Plug 'nathanaelkane/vim-indent-guides'
    Plug 'Yggdroot/indentLine'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'LunarWatcher/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'wakatime/vim-wakatime'
    Plug 'easymotion/vim-easymotion'
call plug#end()
" -------------------- plugins configs -------------------------------
" _________________________ coc.nvim configs _________________________ 
" map <Tab> for navigating menu options
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
                  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" map <CR> for chossing (applying) the hoverd menu option
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
              call CocActionAsync('doHover')
                else
                        call feedkeys('K', 'in')
                          endif
endfunction
" _________________________ indentLine configs _______________________
let g:indentLine_char_list=['┊', '┆', '¦', '|']
let g:indentLine_leadingSpaceEnabled=1 
let g:indentLine_leadingSpaceChar='·'
" ______________________________ rainbow parentheses _________________
" setting (NERDTree=0) causes problems and conflicts
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'guis': [''],
    \   'cterms': [''],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'css': 0,
    \       'html': 0,
     \   }
\}
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle"

" _____________________________ air-line configs _____________________
" Show last command in status line
set showcmd 
" show status bar always
set laststatus=2
" we don't need show mode because mode is printed in the status bar
set noshowmode
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
let g:airline#extensions#branch#enabled = 1
" fix (delay when exiting insert mode)
set ttimeoutlen=50

" -------------------------------- color scheme ----------------------
" ColorSheme
" let g:jellybeans_overrides = {
" \    'background': { 'guibg': '151820' },
" \}
colorscheme night-owl

" ------------------------------ Keybindings -------------------------
" prevents the space default in (Normal Mode)
nmap <space> <nop>
" <Leader> + s sources the (.vimrc) file
noremap <C-s> :source ~/.vimrc<cr>
" remap the key of Entering the command mode
nnoremap ; :
vnoremap ; :

" _________________________ autopaires _______________________________
" make the douple & exit & then back to insert mode so cursor be in between the
" douple (|)
" inoremap " ""<esc>i
" inoremap ' ''<esc>i
" inoremap ( ()<esc>i
" inoremap < <><esc>i
" inoremap { {}<esc>i
" inoremap [ []<esc>i
" _____________________________ plugins maps _________________________
" open CtrlP
nnoremap <C-p> :CtrlP<cr>
nnoremap <C-b> :CtrlPBuffer<cr>
" _____________________________ Toggling _____________________________
" <leader>t toggle Tagbar
noremap <leader>t :TagbarToggle<cr>
" <leader>n to toogle NERDTree
noremap <leader>f :NERDTreeToggle<cr>
" ______________________________ commands of files ___________________
" undo
noremap <C-z> :undo<cr>
" exit to (command mode) execute (:undo) and then back to (normal mode)
imap <C-z> <esc>:undo<cr>i
" remap (redo) 
noremap <C-x> :redo<cr>
" map ( redo ) in (insert mode)
imap <C-x> <esc>:redo<cr>i
" (write the changes)
noremap <leader>w :w<cr>
" ____________________________ windowing & tabbing ___________________
" (open new tab)
noremap <leader>n :tabnew<cr>
" (open splited horizental window) & move cursor to the new window
" (down)
noremap <leader>s :sp<cr>:wincmd j<cr>
" (open splited vertical window) & move cursor to the new window
" (right)
noremap <leader>v :vs<cr>:wincmd l<cr>
" navigating windows
" move cursor to (up) window 
noremap <S-UP> :wincmd k<cr>
" move cursor to (down) window
noremap <S-DOWN> :wincmd j<cr>
" move cursor to (left) window
noremap <S-Left> :wincmd h<cr>
" move cursor to (right) window
noremap <S-Right> :wincmd l<cr>

