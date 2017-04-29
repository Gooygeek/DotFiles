let mapleader=","

" Colours {{{
syntax enable "make pretty colours
set  t_Co=256 "set terminal to use 256 colour
set background=dark "tell vim the background will be dark
"let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme peaksea
colorscheme badwolf
" }}}

" UI Layout {{{
set relativenumber "show line numbers
set cursorline "highlight current line
set wildmenu "visual autocomplete menu
set lazyredraw "redraw only when needed
set showmatch "show matching brackets
set showcmd "shows the command at the bottom
" }}}

" Spaces & Tabs {{{
set tabstop=4 "4 spaces to the tab
set shiftwidth=4 "4 spaces for each (auto)indent
set expandtab "replace tabs with spaces
set smarttab "be smart about tabs
set softtabstop=4 "number of spaces to the tab when editing
filetype indent on "load indentation settings based ont he filetype
filetype plugin on
set autoindent "automatically tabulate when coding
set wrap "lines that are too long will wrap
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
set foldmethod=indent "set what will be folded on
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

" Templates {{{
" used to load in a template file
nnoremap ,html :-1read $HOME/.vim/templates/template.html<CR>
" }}}

" Misc {{{
set backspace=indent,eol,start "backspace works properly
set modelines=1 "file-custom config line
set nocompatible "don't try and act like vi
" toggle absolute and relative line numbers
nnoremap <leader>ln :call ToggleNumber()<CR><CR>
"nnoremap <leader># ^i#<Esc>
" }}}

" Misc Remaps {{{
",u will revert the current line to previous state
nnoremap <leader>u U
"U will undo the undo
nnoremap U <C-r>
"}}}

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

" Plugins {{{
" load plugins into runtime
set runtimepath^=~/.vim/bundle/nerdtree/
set runtimepath^=~/.vim/bundle/nerdcommenter/
" set mappings and settings
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" }}}

" config for this file only
" vim:foldmethod=marker:foldlevel=0
