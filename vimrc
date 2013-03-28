"" disable arrow keys
"noremap <Up> ""
"noremap! <Up> <Esc>
"noremap <Down> ""
"noremap! <Down> <Esc>
"noremap <Left> ""
"noremap! <Left> <Esc>
"noremap <Right> ""
"noremap! <Right> <Esc>

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
set colorcolumn=80

" disable syntax highlighting on long lines
set synmaxcol=2048

" make vim copy to system clipboard
set clipboard=unnamed

" clear screen when exiting VIM
"au VimLeave * :!clear

" map keys for tab management
:map <F7> :tabp<CR>
:map <F8> :tabn<CR>
:map <F9> :tabe<space>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" custom status bar
set noruler
set laststatus=2
set statusline=%t
set statusline+=%m%m%m%m%m%m%m%m%m%m
set statusline+=%=
set statusline+=%c,
set statusline+=%l/%L

" smarter search in terms of letter case
set ignorecase
set smartcase
