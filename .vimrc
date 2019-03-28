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
 Plugin 'ctrlpvim/ctrlp.vim'
 Plugin 'fisadev/vim-ctrlp-cmdpalette'
 "commenting tool
 " [count]<leader>cc
 Plugin 'scrooloose/nerdcommenter'
 " async language checker
 Plugin 'w0rp/ale'

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
 " map  <C-CR> <Plug>(easymotion-bd-w)
 " nmap <C-CR> <Plug>(easymotion-overwin-w)
 
 nnoremap <leader><space> :nohlsearch<CR>
 
 "allows for fuzzysearching in file
 noremap ff :FuzzySearch<CR>
 
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
 " set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*
 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_php_checkers = ['php']
 
 
 "php cs fixer
 let g:php_cs_fixer_rules = "@PSR2"
 
 let g:php_cs_fixer_php_path = "php"               " Path to PHP
 let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
 let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
 let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline informa
 
 set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*     " MacOSX/Linux

 "search configs
:set ignorecase
:set smartcase

 function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
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

function! AddTextShow()
    let [line_end, column_end] = getpos("'>")[1:2]
    let currentLine = split(getline(line_end), GetVisualSelection())
    echo currentLine
    currentLine[1] = "');?>" + currentLine[1]
    currentLine[0] = currentLine[0] + "<?=Text::show('', '"
    setline(line_end, currentLine[0] + getVisualSelection() + currentLine[1]);
endfunction
if stridx(getcwd(), 'aptschat') > 0
    colorscheme koehler
    autocmd BufWritePost *.blade* :!php artisan compile-html
elseif stridx(getcwd(), 'admin') > 0
    colorscheme desert
endif
if stridx(getcwd(), 'laravel2') > 0
    autocmd BufWritePost *ILSUnitresponse.blade* :!php artisan make:ils --propertyCode=VILLAGE1
    autocmd BufWritePost *ILSUnitresponse.blade* :!cp ./storage/xml/* /home/brady/php-tests/php-validator/xmls/
    autocmd BufWritePost *ILSUnitresponse.blade* :!wget http://localhost:8000/?bypass=1
endif
if stridx(getcwd(), 'golden') > 0
    colorscheme desert
    autocmd BufWritePost *.blade* :!php artisan compile-html
elseif stridx(getcwd(), 'admin') > 0
    colorscheme desert
endif
if stridx(getcwd(), 'local') > 0
    colorscheme elflord
    autocmd BufWritePost *.blade* :!php artisan compile-html
elseif stridx(getcwd(), 'admin') > 0
    colorscheme desert
endif
set noeb vb t_vb=

"tell netrw to show file info by default
let g:netrw_liststyle = 1
let g:netrw_fastbrowse = 2


 nnoremap tt :CtrlPTag<CR>
 nnoremap <leader>f :CtrlP<CR>
 nnoremap <leader>c :CtrlPCmdPalette<CR>
 " let g:ctrlp_cmdpalette_execute = 1
let g:ctrlp_max_files = 0

nnoremap <leader>t :CtrlPTag<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>g :CtrlPLine<CR>
"nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>c :CtrlPCmdPalette<CR>
" let g:ctrlp_cmdpalette_execute = 1
