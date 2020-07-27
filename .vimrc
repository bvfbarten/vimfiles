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
"allows for fuzzysearching in file
Plugin 'ggVGc/vim-fuzzysearch'
"awesome search tool
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fisadev/vim-ctrlp-cmdpalette'
Plugin 'stefandtw/quickfix-reflector.vim'
Plugin 'freitass/todo.txt-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mbbill/undotree'
Plugin 'majutsushi/tagbar'
" Plugin 'jsit/vim-customcpt'
"commenting tool
" [count]<leader>cc 
" [count]<leader>c<space> toggles
Plugin 'scrooloose/nerdcommenter'
so ~/.vim/plugins/vim-customcpt/plugin/vim-customcpt.vim
" autocomplete?
Plugin 'zxqfl/tabnine-vim'
"Plugin 'ervandew/supertab'
"Plugin 'maxboisvert/vim-simple-complete'
" async language checker
if v:version >= 800
    " async language checker can only be ran on vim 8+
    Plugin 'dense-analysis/ale'
endif


let g:vsc_type_complete_length = 1
"set complete-=t
"set complete-=i
" Plugin 'stephpy/vim-php-cs-fixer'
" cs"' change surround from " to '
" ds" delete surrounding "
" ysiw[ surround word with [ ]
" visual select then S<div class="blah"> surrounds selection with <div class="blah">
Plugin 'tpope/vim-surround'
" Plugin 'easymotion/vim-easymotion'
Plugin 'mattn/emmet-vim'
"csv tool
Plugin 'chrisbra/csv.vim'

call vundle#end()


"jump to next hunk (change): ]c
"jump to previous hunk (change): [c.




filetype plugin indent on


" brief help
" :pluginlist       - lists configured plugins
" :plugininstall    - installs plugins; append `!` to update or just :pluginupdate
" :pluginsearch foo - searches for foo; append `!` to refresh local cache
" :pluginclean      - confirms removal of unused plugins; append `!` to auto-approve removal
" plugininstall

"copy and paste
vnoremap <c-c> "+y
noremap <c-v> "+p


"tags
set tags=./tags;/
map <c-\> :tab split<cr>:exec("tag ".expand("<cword>"))<cr>
map <a-]> :vsp <cr>:exec("tag ".expand("<cword>"))<cr>

"tagbar
map <F8> :TagbarToggle<CR>

" files
syntax on          " enable syntax processing
filetype indent on      " load filetype-specific indent files

" tabs
set tabstop=4       " number of visual spaces per tab
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces


" ui
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line

set wildmenu            " visual autocomplete for command menu

"searching
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
"easy motion over the window
" map  <c-cr> <plug>(easymotion-bd-w)
" nmap <c-cr> <plug>(easymotion-overwin-w)

nnoremap <leader><space> :nohlsearch<cr>

"allows for fuzzysearching in file
noremap ff :fuzzysearch<cr>

" highlight last inserted text
nnoremap gv `[v`]

" backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" editor
set modelines=1


"ctrl p

"    press <f5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
"    press <c-f> and <c-b> to cycle between modes.
"    press <c-d> to switch to filename only search instead of full path.
"    press <c-r> to switch to regexp mode.
"    use <c-j>, <c-k> or the arrow keys to navigate the result list.
"    use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
"    use <c-n>, <c-p> to select the next/previous string in the prompt's history.
"    use <c-y> to create a new file and its parent directories.
"    use <c-z> to mark/unmark multiple files and <c-o> to open them.

set statusline+=%#warningmsg#
" set statusline+=%{syntasticstatuslineflag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_php_checkers = ['php']


"php cs fixer
let g:php_cs_fixer_rules = "@psr2"

let g:php_cs_fixer_php_path = "php"               " path to php
let g:php_cs_fixer_enable_default_mapping = 1     " enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " return the output of command if 1, else an inline informa

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*     " macosx/linux

"search configs
:set ignorecase
:set smartcase

function! Getvisualselection()
    " why is this not a built-in vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! Addtextshow()
    let [line_end, column_end] = getpos("'>")[1:2]
    let currentline = split(getline(line_end), getvisualselection())
    echo currentline
    currentline[1] = "');?>" + currentline[1]
    currentline[0] = currentline[0] + "<?=text::show('', '"
    setline(line_end, currentline[0] + getvisualselection() + currentline[1]);
endfunction
if stridx(getcwd(), 'aptschat') > 0
    colorscheme koehler
    autocmd bufwritepost *.blade* :!php artisan compile-html
elseif stridx(getcwd(), 'admin') > 0
    colorscheme desert
endif
if stridx(getcwd(), 'golden') > 0
    colorscheme desert
    autocmd bufwritepost *.blade* :!php artisan compile-html
elseif stridx(getcwd(), 'admin') > 0
    colorscheme desert
endif

function! Fromlatintoutf8()
    :%s/"/"/g
    :%s/"/"/g
    :%s/'/'/g
endfunction

function! Sourcefile()
    if filereadable("aftersave.vim")
        execute 'source ' . fnameescape('./aftersave.vim')
    endif
endfunction

autocmd bufwritepost ** :call Sourcefile()
if stridx(getcwd(), 'local') > 0
    colorscheme elflord
    autocmd bufwritepost *.blade* :!php artisan compile-html
elseif stridx(getcwd(), 'admin') > 0
    colorscheme desert
endif
set noeb vb t_vb=

"tell netrw to show file info by default
let g:netrw_liststyle = 1
let g:netrw_fastbrowse = 2


nnoremap td :tabnew ~/.todo-txt/todo.txt<cr>
nnoremap tt :CtrlPTag<cr>
nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>c :CtrlPCmdPalette<cr>
" let g:ctrlp_cmdpalette_execute = 1
let g:ctrlp_max_files = 0


nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>g :CtrlPLine<cr>
"nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>c :CtrlPCmdPalette<cr>
" let g:ctrlp_cmdpalette_execute = 1
"
" snippets
autocmd filetype php iabbrev <buffer> array_splice array_splice ( array &$input , int $offset [, int $length = count($input) [, mixed $replacement = array() ]] ) 
autocmd filetype php iabbrev <buffer>  array_slice array_slice ( array $array , int $offset [, int $length = null [, bool $preserve_keys = false ]] )
autocmd filetype php iabbrev <buffer>  strpos strpos ( string $haystack , mixed $needle [, int $offset = 0 ] ) 

" echom "test 245"
" source ~/.vim/plugins/python-autocomplete/python-autocomplete.vim
