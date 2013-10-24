" disable arrow keys
noremap <Up> ""
noremap! <Up> <Esc>
noremap <Down> ""
noremap! <Down> <Esc>
noremap <Left> ""
noremap! <Left> <Esc>
noremap <Right> ""
noremap! <Right> <Esc>

" display line numbers
set number

" don't backup files
set nobackup
set nowritebackup
set nowritebackup

" enable auto indentation
set autoindent

" display white space
"set list

" 4 spaces instead of tabs
set ts=4 sts=0 sw=4 expandtab

" line width
" set textwidth=79

" display right margin
set colorcolumn=50,80

" disable syntax highlighting on long lines
set synmaxcol=2048

" make vim copy to system clipboard, need +xterm_clipboard
"set clipboard=unnamed

" clear screen when exiting VIM
"au VimLeave * :!clear

" map keys for tab management
:map <F7> :tabp<CR>
:map <F8> :tabn<CR>
:map <F9> :tabe<space>

" spell-check toggle
inoremap <silent> <F6> <c -O>:call SpellToggle()<cr>
map <silent> <F6> :call SpellToggle()<cr>
function SpellToggle()
    if &spell == 1
        set nospell
    else
        set spell spelllang=en_us
    endif
endfunction

" code paste toggle (no indenting)
set pastetoggle=<F2>

" :w!! will save the file as root (when forgetting to sudo vim)
cmap w!! %!sudo tee > /dev/null %

" close shortcuts
:map <F3> :w<CR>
:map <F4> :q<CR>

" reload document shortcut
:map <F5> :edit<CR>

" custom status bar
set noruler
set laststatus=2
set statusline=%t
" make it really obvious that the file was modifed
set statusline+=%m%m%m%m%m%m%m%m%m%m%m%m%m%m
set statusline+=%=
set statusline+=%c,
set statusline+=%l/%L

" smarter search in terms of letter case
set ignorecase
set smartcase

" inserts a newline on Enter, an above newline on Shift+Enter
":map <Enter> o<ESC>
":map <S-Enter> O<ESC>

" allows to insert one single character when pressing Space
:nmap <Space> i_<Esc>r
