let mapleader=","

" Colours {{{
syntax enable "make pretty colours
set  t_Co=256 "set terminal to use 256 colour
"set background=dark "tell vim the background will be dark
"let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme peaksea
"colorscheme badwolf
colorscheme monokai
" }}}

" UI Layout {{{
set number "show absolute line number for current line
set relativenumber "show relative line numbers
set cursorline "highlight current line
set wildmenu "visual autocomplete menu
set lazyredraw "redraw only when needed
set showmatch "show matching brackets
set showcmd "shows the command at the bottom
set laststatus=2 "always show the status line
"dont show the mode. will still be indicated in the statusline
autocmd VimEnter * set noshowmode
set scrolloff=3 "maintain a minimum of 3 lines above and below the cursor. Except for top and bottom of the file
set visualbell "flash the screen if attempting an invlaid operation
" }}}

" Statusline {{{
" g:currentmode {{{
let g:currentmode={
            \ 'n'  : 'N ',
            \ 'no' : 'N·Operator Pending ',
            \ 'v'  : 'V ',
            \ 'V'  : 'V·Line ',
            \ '^V' : 'V·Block ',
            \ 's'  : 'Select ',
            \ 'S'  : 'S·Line ',
            \ '^S' : 'S·Block ',
            \ 'i'  : 'I ',
            \ 'R'  : 'R ',
            \ 'Rv' : 'V·Replace ',
            \ 'c'  : 'Command ',
            \ 'cv' : 'Vim Ex ',
            \ 'ce' : 'Ex ',
            \ 'r'  : 'Prompt ',
            \ 'rm' : 'More ',
            \ 'r?' : 'Confirm ',
            \ '!'  : 'Shell ',
            \ 't'  : 'Terminal '
            \}
" }}}
" Filesize {{{
function! FileSize()
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes / 1024
    endif
    if (exists('kbytes') && kbytes >= 1000)
        let mbytes = kbytes / 1000
    endif

    if bytes <= 0
        return '0'
    endif

    if (exists('mbytes'))
        return mbytes . 'MB '
    elseif (exists('kbytes'))
        return kbytes . 'KB '
    else
        return bytes . 'B '
    endif
endfunction
" }}}
" Set data to show
set laststatus=2
set statusline=
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ %<%F\ %m\ %w\        " File+path +[is modified]+[is preview] 
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%0*\ %3p%%\ %l/%L:\ %3c\                 " Percent% row/totalrow : column
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
set foldminlines=5 "must bave at least 6 lines to make a fold
" }}}

" Movement {{{
"move vertically by visual line not by actual line (good for when text is wrapped)
"when using 'j' and 'k', in insert mode the normal method is used if it is multiple lines at
"a time, thus it doesn't break when using relative linenumbers
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <down> g<down>
nnoremap <up> g<up>
inoremap <down> <Esc>gji
inoremap <up> <Esc>gki
" move to start/end of line
nnoremap B ^
nnoremap E $
" }}}

" Tags {{{
command! MakeTags !ctags -R .
" }}}

" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Snippets {{{
" load in a template file
nnoremap ,html :-1read $HOME/.vim/templates/template.html<CR>
" abberviations/custom autocorrect
iabbr teh the
iabbr ture true
iabbr flase false
" }}}

" Misc {{{
set backspace=indent,eol,start "backspace works properly
set modelines=1 "file-custom config line
set nocompatible "don't try and act like vi
" toggle absolute and relative line numbers
nnoremap <leader>ln :call ToggleNumber()<CR><CR>
" load filetype specific configs
source ~/.vim/configs/.vimfiletype
" }}}

" Misc Remaps {{{
",u will revert the current line to previous state
nnoremap <leader>u U
"U will undo the undo
nnoremap U <C-r>
" leader up/down will move the current line up or down
nnoremap <leader><up> ddkP
nnoremap <leader><down> ddp
" custom comma commands
" delete/change inner ","
nnoremap di, f,dT,
nnoremap ci, f,cT,
" quick pairs
inoremap <leader>' ''<left>
inoremap <leader>" ""<left>
inoremap <leader>( ()<left>
inoremap <leader>{ {}<left>
inoremap <leader>[ []<left>
" insert lines without going into insert mode
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j
" open/close tab
nnoremap g<C-t> :tabnew<CR>
nnoremap gc :tabclose<CR>
" replace all instances of the word under the cursor/visualbuffer. autofill
" old word. CONSIDER using 'g&', the shortcut to repeat the last replacement
" for all lines or '&' for just the current line
nnoremap <Leader>rw :%s/<C-r><C-w>/<C-r><C-w>
vnoremap <Leader>rw y:%s/<C-r>"/<C-r>"
" leader up/down will move the current line up or down
nnoremap <leader><up> ddkP
nnoremap <leader><down> ddp
" create 'jump' point
nnoremap <leader>+ i<++><Esc>
inoremap <leader>+ <++>
" jump to next jump point
nnoremap <space><space> /<++><CR>df>i
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
set runtimepath^=~/.vim/bundle/vim-easymotion/
" set mappings and settings
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" }}}


" config for this file only
" vim:foldmethod=marker:foldlevel=0:foldminlines=0
