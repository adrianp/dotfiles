" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.

set nocompatible
filetype off
set encoding=utf-8
autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd! bufwritepost vimrc source ~/.vimrc
let mapleader=","
nmap <silent> <leader>rc :e ~/src/dotfiles/vimrc<CR>
nnoremap ; :

" Vundle: https://github.com/gmarik/vundle.git
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Run :PluginInstall to install these
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'scrooloose/syntastic'
Plugin 'Chiel92/vim-autoformat'
Plugin 'alvan/vim-closetag'
Plugin 'python/black'
Plugin 'tpope/vim-rhubarb'

call vundle#end()
filetype plugin indent on

let g:black_virtualenv="~/.vim_black"
let g:black_linelength=120

" file explorer options
map <leader>t :Explore<CR>
let g:netrw_liststyle=3

" set xterm title
set title

" access the yank registers
map <leader>r :reg<CR>

" disable whietspace diff
set diffopt=iwhite

" ...or just use the mouse
"set mouse=a

" toggle line numbers
set number
set relativenumber
nnoremap <leader>l :set norelativenumber!<CR>
nnoremap <F10> :set number! norelativenumber!<CR>

" smart buffers
set hidden
set switchbuf=useopen

" be a man and don't use backup files
set nobackup
set nowritebackup
set noswapfile
set nowb

" display trailing white space
set list listchars=tab:▸\ ,trail:·

" use spaces
set ts=4 sts=0 sw=4
autocmd Filetype javascript,jsx,xml,bib,text,tex,plaintex,html setlocal ts=2 sts=2 sw=2

" always report yanks
set report=0

" use tabs
"set tabstop=4
"set shiftwidth=4

" display right margin
set colorcolumn=80,100,120

" display current line
"set cursorline

" don't redraw screen if not necessary
set lazyredraw

" syntax highlighting and auto/smart-indenting
syntax on
filetype on
set synmaxcol=200
set background=light
set autoindent
set smartindent
set smarttab
set expandtab " for using spaces
"set noexpandtab " for using tabs
set copyindent

" clear screen when exiting VIM
"au VimLeave * :!clear

" map keys for buffer management
map <leader>< :bp<CR>
map <leader>> :bn<CR>
map <leader>/ :bd<CR>

" spell-check toggle
inoremap <silent> <F6> <c -O>:call SpellToggle()<CR>
map <silent> <F6> :call SpellToggle()<CR>
function! SpellToggle()
    if &spell == 1
        set nospell
    else
        set spell spelllang=en_gb
    endif
endfunction

" somewhat better spell-checker
map <F3> :!aspell -l en_gb -c %<CR>

" press leader key twice to enter visual mode
map <Leader><Leader> V

" colorscheme toggle
color default
let g:icantsee=1
highlight ColorColumn ctermbg=LightGray
inoremap <silent> <F12> <c -O>:call ColorToggle()<CR>
map <silent> <F12> :call ColorToggle()<CR>
function! ColorToggle()
    if g:icantsee == 1
        color evening
        let g:icantsee=0
        highlight ColorColumn ctermbg=LightGray
    else
        color default
        let g:icantsee=1
        highlight ColorColumn ctermbg=LightGray
    endif
endfunction

" code paste toggle (no indenting)
set pastetoggle=<F2>

" :w!! will save the file as root (when forgetting to sudo vim)
cmap w!! %!sudo tee > /dev/null %

:map <leader>; :w<CR>
:map <leader>' :wa<CR>

" reload/open document shortcut
:map <F5> :edit 

" custom status bar
set noruler
set laststatus=2
set statusline=%n\|%F
"" make it really obvious that the file was modifed
set statusline+=\ %m%m%m%m%m%m%m%m%m%m%m%m%m%m
set statusline+=%=
set statusline+=[%{mode()}%{mode()}%{mode()}]
set statusline+=%{fugitive#statusline()}
set statusline+=%y
set statusline+=[%c,%p\|%L]

" smarter search
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <leader><space> :noh<cr>

" allows to insert one single character when pressing Space
:nmap <Space> i_<Esc>r

" exuberant ctags binding
"set tags=tags

" persistent undo
set undofile
set undodir=~/var/vim
set undolevels=1000

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
set history=10000

" display incomplete commands
set showcmd

" paste on a newline
map <leader>o :pu<CR>

" quickly open a temp file
map <leader>q :e ~/var/scrapbook.txt<CR>

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
map <leader>ntf :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeWinPos="right"
let NERDTreeShowLineNumbers=0
" disable buffer delete in NERDTree
autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
let g:NERDTreeWinPos = "left"

" Syntastic: https://github.com/scrooloose/syntastic
map <leader>e :Errors<CR>
map <leader>sr :SyntasticReset<CR>
map <leader>. :lnext<CR>
map <leader>z :lclose<CR>
"let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_less_checkers = ['lessc']
"let g:syntastic_quiet_messages = {"!level":  "errors"}
let g:syntastic_python_pylint_post_args = '--rcfile=.pylintrc' 
let g:syntastic_python_flake8_args='--max-line-length=120'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0

" detect JSON files correctly
au BufRead,BufNewFile *.json set filetype=json

" detect LESS files correctly
au BufRead,BufNewFile *.less set filetype=less

" CTRLP: http://kien.github.io/ctrlp.vim/#installation
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*,*/node_modules/*,*.pyc,*/bower_components/*,*/*.egg-info/*
map <leader>b :CtrlPBuffer<CR>
map <leader>p :CtrlP<CR>
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

" don't set readonly mode in diff
if &diff
    set noro
endif

" copy/ paste to X system clipboard
map <leader>xx :w !xsel -i -b<CR><CR>
map <leader>vv :r!xsel -b<CR>

" LaTeX-Box: https://github.com/LaTeX-Box-Team/LaTeX-Box
map <leader>mkk :Latexmk<CR>
map <leader>mkc :LatexmkClean<CR>
map <leader>mke :LatexErrors<CR>
map <leader>mkv :LatexView<CR>
let g:tex_flavor = "latex"

" remove trailling whitespace
nnoremap <Leader>rtw :%s/\s\+$//<cr>:let @/=''<CR>

" use Q for formatting the current selection or paragraph
vmap Q gq
nmap Q gqap

" sane wrapped line navigation
nnoremap j gj
nnoremap k gk

" easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" use tab to see matching bracket
nnoremap <tab> %
vnoremap <tab> %

" split vertically and switch to split
nnoremap <leader>w <C-w>v<C-w>l
map <leader>3 :n#<CR>

" YouCompleteMe: https://github.com/Valloric/YouCompleteMe
let g:ycm_confirm_extra_conf=0
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" DelimitMate: https://github.com/Raimondi/delimitMate
function! BreakLine()
  if (mode() == 'i')
    return ((getline(".")[col(".")-2] == '{' && getline(".")[col(".")-1] == '}') ||
          \(getline(".")[col(".")-2] == '(' && getline(".")[col(".")-1] == ')'))
  else
    return 0
  endif
endfun
inoremap <expr> <CR> BreakLine() ? "<CR><ESC>O" : "<CR>"
let delimitMate_excluded_ft = "html"

" vim-autoformat: https://github.com/Chiel92/vim-autoformat
noremap <leader>f :Autoformat<CR><CR>

" Git commit messages helpers
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
autocmd Filetype gitcommit setlocal textwidth=72

" code folding settings
set foldmethod=indent  " fold by syntax highlighting
set foldnestmax=10  " deepest fold is 10 levels
set nofoldenable  " dont fold by default

" even faster ESC-aping (https://powerline.readthedocs.org/en/latest/tipstricks.html#vim)
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" ask before leaving with unsaved changes
set confirm

" hide omnifunc scratch window after cursor move
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" use dictionary completion in spelling mode
set complete+=kspell

" virtualenv support for Python
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
  "project_base_dir = os.environ['VIRTUAL_ENV']
  "activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  "execfile(activate_this, dict(__file__=activate_this))
"EOF

" HTML tags jumping
runtime macros/matchit.vim

" Use arrows for pane resizing (note that this disables arrow scroll, use HJKL)
map <Up> <C-W>-
map <Down> <C-W>+
map <Right> <C-W>>
map <Left> <C-W><


" get full path to current file (like readlink -f)
map <leader>rlf :echo expand('%:p')<CR>

" expansions
iab tes$ Tested-by: <@>
iab rev$ Reviewed-by: <@>
iab ack$ Acked-by: <@>
iab rep$ Reported-by: <@>
iab cab$ Co-authored-by: <@>
iab sob$ Signed-off-by: <@>
iab fix$ Fixes:
iab hw$ "Hello World!"
iab pdb$ import pdb; pdb.set_trace()
iab ipdb$ import ipdb; ipdb.set_trace()
iab pudb$ import pudb; pu.db
iab cl$ console.log(
iab st$ console.log(new Error().stack);
iab tdt$ # TODO(adrianp):
iab fmt$ # FIXME(adrianp):
iab dbg$ /* eslint-disable no-debugger */ debugger;
iab #$ ####################################################################################################
iab -$ #---------------------------------------------------------------------------------------------------
iab ptb$ import traceback; traceback.print_exc()
