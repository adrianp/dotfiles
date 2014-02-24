" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.

set nocompatible
filetype off
set encoding=utf8
autocmd! bufwritepost .vimrc source ~/.vimrc
filetype plugin indent on
let mapleader=","

" Vundle: https://github.com/gmarik/vundle.git
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Run $ vim +BundleInstall +qall or :BundleInstall
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Shutnik/jshint2.vim'
Bundle 'nvie/vim-flake8'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-surround'
"Bundle 'marijnh/tern_for_vim'

" be pretentious as fuck
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" toggle line numbers
set number
set relativenumber
nnoremap <leader>l :set norelativenumber!<CR>
nnoremap <F10> set number! norelativenumber!<CR>

" smart buffers
set hidden
set switchbuf=useopen

" be a man and don't use backup files
set nobackup
set nowritebackup
set noswapfile
set nowb

" display trailing white space
set list listchars=trail:·

" 4 spaces instead of tabs
set ts=4 sts=0 sw=4

" display right margin
"set textwidth=80
set colorcolumn=80

" syntax highlighting and auto/smart-indenting
syntax on
filetype on
set synmaxcol=2048
set background=light
set autoindent
set smartindent
set smarttab
set expandtab

" make vim copy to system clipboard, need +xterm_clipboard
"set clipboard=unnamed

" clear screen when exiting VIM
"au VimLeave * :!clear

" map keys for buffer management
:map <F7> :bp<CR>
:map <F8> :bn<CR>
:map <F9> :bdelete<CR>

" spell-check toggle
inoremap <silent> <F6> <c -O>:call SpellToggle()<CR>
map <silent> <F6> :call SpellToggle()<CR>
function SpellToggle()
    if &spell == 1
        set nospell
    else
        set spell spelllang=en_us
    endif
endfunction

" colorscheme toggle
let g:icantsee=1
inoremap <silent> <F12> <c -O>:call ColorToggle()<CR>
map <silent> <F12> :call ColorToggle()<CR>
function ColorToggle()
    if g:icantsee == 1
        color evening
        let g:icantsee=0
    else
        color default
        let g:icantsee=1
    endif
endfunction

" code paste toggle (no indenting)
set pastetoggle=<F2>

" :w!! will save the file as root (when forgetting to sudo vim)
cmap w!! %!sudo tee > /dev/null %

" close shortcuts
:map <F3> :w<CR>
:map <F4> :q<CR>

" reload/open document shortcut
:map <F5> :edit 

" custom status bar
set noruler
set laststatus=2
set statusline=%t
" make it really obvious that the file was modifed
set statusline+=%m%m%m%m%m%m%m%m%m%m%m%m%m%m
set statusline+=%=
set statusline+=%c,
set statusline+=%l/%L

" smarter search
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <silent> <C-l> :nohl<CR><C-l>

" inserts a newline on Enter, an above newline on Shift+Enter
":map <Enter> o<ESC>
":map <Shift-Enter> O<ESC>

" allows to insert one single character when pressing Space
:nmap <Space> i_<Esc>r

" exuberant ctags binding
"set tags=tags

" persistent undo
set undofile
set undodir=~/var/vim

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

" command history size
set history=1000

" display incomplete commands
set showcmd

" quickly open a temp file
map <leader>q :e ~/tmp/scrapbook<CR>

" remember cursor and buffers states
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%
set nostartofline

" (un)indent
vnoremap < <gv
vnoremap > >gv

" cd to directory of current file
cmap cd. lcd %:p:h

" don't wrap lines
set nowrap

" search for selected text, forwards (*) or backwards (#).
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" NERDTree: https://github.com/scrooloose/nerdtree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeWinPos="right"
let NERDTreeShowLineNumbers=0

" Flake8: https://github.com/nvie/vim-flake8
autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>

" JSHint: https://github.com/Shutnik/jshint2.vim
nnoremap <leader>j :JSHint<CR>
inoremap <leader>j <C-O>:JSHint<CR>
vnoremap <leader>j  :JSHint<CR>
cnoremap <leader>j JSHint

" CTRLP: http://kien.github.io/ctrlp.vim/#installation
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*,*/node_modules/*,*.pyc,*/bower_components/*,*/*.egg-info/*
map <leader>b :CtrlPBuffer<CR>

" don't set readonly mode in diff
if &diff
    set noro
endif

" toggle quickfix window
"map <leader>wc :ccl<CR>
"map <leader>wo :copen<CR>

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
