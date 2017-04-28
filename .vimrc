" Colours {{{
syntax enable "make pretty colours
set  t_Co=256 "set terminal to use 256 colour
set background=dark "tell vim the background will be dark
colorscheme desert "set the base colourscheme to be desert
" non-syntax text to grey and the background to black
highlight Normal ctermfg=lightgrey ctermbg=black
" set line numbers to be dark grey
highlight LineNr ctermfg=darkgrey
" }}}

" Misc {{{
set backspace=indent,eol,start "backspace works properly
set modelines=1 "file-custom config line
let mapleader=","
set nocompatible "not try and act like vi
" toggle absolute and relative line numbers
nnoremap <leader>ln :call ToggleNumber()<CR><CR>
nnoremap <leader># ^i#<Esc>
"}}}

" Spaces & Tabs {{{
set tabstop=4 "4 spaces to the tab
set expandtab "replace tabs with spaces
set softtabstop=4 "number of spaces to the tab when editing
filetype indent on "load indentation settings based ont he filetype
filetype plugin on
set autoindent "automatically tabulate when coding
" }}}

" UI Layout {{{
set number "show line numbers
set cursorline "highlight current line
set wildmenu "visual autocomplete menu
set lazyredraw "redraw only when needed
set showmatch "show matching brackets
set wrap "lines that are too long will wrap
set showcmd "shows the command at the bottom
" }}}

" Searching {{{
set incsearch "search as characters are entered
set hlsearch "highlight matches
set ignorecase "ignore case
"turn off search highlighing
nnoremap <leader><space> :nohlsearch<CR> 
set path+=** "recursive directory searching
" }}}

" Folding {{{
set foldenable "ensable folding
set foldmethod=indent "set folds based on indent level
" }}}

" Movement {{{
"move vertically by visual line not by actual line (good for when text is wrapped)
nnoremap j gj
nnoremap k gk
nnoremap <down> g<down>
nnoremap <up> g<up>
inoremap <down> <Esc>gji
inoremap <up> <Esc>gki
" move to start/end of line
nnoremap B ^
nnoremap E $
" }}}

" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Snippets {{{
" used to load in a template file
nnoremap ,html :-1read $HOME/.vim/templates/template.html<CR>
" }}}

" Custom functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
       set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
" }}}


" config files for this file only
" vim:foldmethod=marker:foldlevel=0
