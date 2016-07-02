" old compat
set nocompatible
" display lines number relative to the cursor
" position
set number
set relativenumber

" change the mapleader from \ to ,
let mapleader=","

filetype plugin indent on
" syntax highlight code
syntax on

" pathogen configuration
runtime! config/**/*.vim

" disable thoses plugins 
" i currently do not use thoses
let g:pathogen_disabled = ['neocomplete.vim', 'neosnippet.vim']

" Initialisation de pathogen
call pathogen#infect()
call pathogen#helptags()

" nerdtree toggle on ,n
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" faster window focus move
map <silent> <A-Up> :wincmd k<CR>
map <silent> <A-Down> :wincmd j<CR>
map <silent> <A-Left> :wincmd h<CR>
map <silent> <A-Right> :wincmd l<CR>

" Quickly edit(,ev)/reload(,sv) the vimrc file
" Not that usefull
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" @see http://nvie.com/posts/how-i-boosted-my-vim/
set hidden
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all
set smarttab      " insert tabs on
set hlsearch
set incsearch

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

" configure basic ignore for vim
" those ignore regex won't be open by args, find, ctrlp
set wildignore=*.swp,*.bak,*.pyc,*.class,*~,*.db,*.zip,*.tar,*.tgz,*.gz,*.o,*.so,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/node_modules/*,*.dll,*/tmp/*,*/.data/*,*/.cache/*

set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" Open tagbar pane on ,tb
" i will probably remove this plugin, it relies on ctags
" and is not that usefull <C-d>(scroll down half screen)
" <C-F> (scroll done full screen) <C-u> (scroll up half screen)
" is most of the time enough
nmap <leader>tb :TagbarToggle<CR>

" customize status line
" plugin vim-buftabline and vim-airline do most of the job
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2

" syntastic is code linter integration to vim
" base configuration fot syntastic plugin
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" use eslint as js linter
let g:syntastic_javascript_checkers = ['eslint']

" php-cs-fixer default configuration
let g:php_cs_fixer_config = "sf23" 

" vom-jsbeautify integration
" beautiyfy js/jsonjsx/html on <leader>f
" map <leader>f :call JsBeautify()<CR>
" or
autocmd FileType javascript noremap <buffer>  <leader>f :call JsBeautify()<CR>
" for json
autocmd FileType json noremap <buffer> <leader>f :call JsonBeautify()<CR>
" for jsx
autocmd FileType jsx noremap <buffer> <leader>f :call JsxBeautify()<CR>
" for html
autocmd FileType html noremap <buffer> <leader>f :call HtmlBeautify()<CR>
"
" Map <leader>f to run CSScomb on css/less/sass files only.
autocmd FileType css noremap <buffer> <leader>f :CSScomb<CR>
autocmd FileType less noremap <buffer> <leader>f :CSScomb<CR>
autocmd FileType sass noremap <buffer> <leader>f :CSScomb<CR>

" " Automatically comb your CSS on save
autocmd BufWritePre,FileWritePre *.css,*.less,*.scss,*.sass silent! :CSScomb

" enable neocomplete at startup
let g:neocomplete#enable_at_startup = 1

"
" vim-php-namespace is use to quick insert use in php
"
function! IPhpInsertUse()
  call PhpInsertUse()
  call feedkeys('a',  'n')
endfunction

" ,u to add class use in php files
autocmd FileType php inoremap <leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <leader>u :call PhpInsertUse()<CR>
" ,s to sort class uses
autocmd FileType php inoremap <Leader>s <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>s :call PhpSortUse()<CR>

" faster buffer navigation
nnoremap <C-N> :bnext<CR>
nnoremap <C-M> :bprev<CR>

" make ctrlp ignore content of your gitignore
" @see https://medium.com/a-tiny-piece-of-vim/making-ctrlp-vim-load-100x-faster-7a722fae7df6
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " TODO find a way to make ag ignore files in .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
