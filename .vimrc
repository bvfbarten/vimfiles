set nocompatible
filetype off

set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set number
set rnu
            

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/.vim/vundles')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'fisadev/vim-ctrlp-cmdpalette'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'

call vundle#end()

filetype plugin indent on


" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" PluginInstall

"copy and paste
vnoremap <C-c> "+y
noremap <C-v> "+p

"tags
set tags=./tags;/
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" files
syntax on          " enable syntax processing
filetype indent on      " load filetype-specific indent files

" tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces


" UI
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line

set wildmenu            " visual autocomplete for command menu

"searching
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
"easy motion over the window
map  <C-CR> <Plug>(easymotion-bd-w)
nmap <C-CR> <Plug>(easymotion-overwin-w)

nnoremap <leader><space> :nohlsearch<CR>

" folding
set foldnestmax=99 " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level


" movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk


" highlight last inserted text
nnoremap gV `[v`]


" Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Editor
set modelines=1


"Ctrl P

"    Press <F5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
"    Press <c-f> and <c-b> to cycle between modes.
"    Press <c-d> to switch to filename only search instead of full path.
"    Press <c-r> to switch to regexp mode.
"    Use <c-j>, <c-k> or the arrow keys to navigate the result list.
"    Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
"    Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
"    Use <c-y> to create a new file and its parent directories.
"    Use <c-z> to mark/unmark multiple files and <c-o> to open them.

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php']


"php cs fixer
let g:php_cs_fixer_rules = "@PSR2"

let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline informa


nnoremap <leader>t :CtrlPTag<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>c :CtrlPCmdPalette<CR>
" let g:ctrlp_cmdpalette_execute = 1
