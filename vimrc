" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.

" be pretentious as fuck
noremap <Up> ""
noremap! <Up> <Esc>
noremap <Down> ""
noremap! <Down> <Esc>
noremap <Left> ""
noremap! <Left> <Esc>
noremap <Right> ""
noremap! <Right> <Esc>

" toggle line numbers
set number
nnoremap <F10> :set nonumber!<CR>

" smart buffers
set hidden

" be a man and don't use backup files
set nobackup
set nowritebackup
set noswapfile
set nowb

" auto and smart indentation
set autoindent
set smartindent
set smarttab
set expandtab

" display white space
"set list

" 4 spaces instead of tabs
set ts=4 sts=0 sw=4

" line width
"set textwidth=79

" display right margin
set colorcolumn=50,80

" syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on
set synmaxcol=2048
set background=light

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
":map <Shift-Enter> O<ESC>

" allows to insert one single character when pressing Space
:nmap <Space> i_<Esc>r

" exuberant ctags binding
set tags=tags

" persistent undo
set undofile
set undodir=~/var/vim

" highlighted and incremental search
set hlsearch
set incsearch

" display completion options
set wildmenu

" tweaked scrolling
set scrolloff=5
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Yes, I know!
set shortmess=atI

" don't be obnoxious
set visualbell

" expansions
iab tes$ Tested-by: <@>
iab rev$ Reviewed-by: <@>
iab akb$ Acked-by: <@>
iab rep$ Reported-by: <@>
iab cab$ Co-authored-by: <@>
iab sob$ Signed-off-by: Adrian-Tudor Panescu <adrian@panescu.com>
iab hw$ "Hello World!"
iab ipdb$ import ipdb<CR>ipdb.set_trace()
iab cl$ console.log(

" ctrlp.vim: http://kien.github.io/ctrlp.vim/#installation
" :helptags ~/.vim/bundle/ctrlp.vim/doc
"set runtimepath^=~/.vim/bundle/ctrlp.vim
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*,*/node_modules/*,*.pyc,*/bower_components/*,*/*.egg-info/*
