set nocompatible
set number
set relativenumber

" change the mapleader from \ to ,
let mapleader=","

filetype plugin indent on
syntax on

runtime! config/**/*.vim

let g:pathogen_disabled = ['neocomplete.vim', 'neosnippet.vim']

" Initialisation de pathogen
call pathogen#infect()
call pathogen#helptags()

" nerdtree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <silent> <A-Up> :wincmd k<CR>
map <silent> <A-Down> :wincmd j<CR>
map <silent> <A-Left> :wincmd h<CR>
map <silent> <A-Right> :wincmd l<CR>

" Quickly edit/reload the vimrc file
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
set wildignore=*.swp,*.bak,*.pyc,*.class,*~,*.db,*.zip,*.tar,*.tgz,*.gz,*.o,*.so,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/node_modules/*,*.dll,*/tmp/*,*/.data/*,*/.cache/*
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

nmap <leader>tb :TagbarToggle<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set laststatus=2

" map <c-f> :call JsBeautify()<CR>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<CR>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<CR>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<CR>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<CR>
" for css or scss
" autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<CR>
"
" Map bc to run CSScomb. bc stands for beautify css
autocmd FileType css noremap <buffer> <leader>bc :CSScomb<CR>
" " Automatically comb your CSS on save
autocmd BufWritePre,FileWritePre *.css,*.less,*.scss,*.sass silent! :CSScomb

let g:syntastic_javascript_checkers = ['eslint']

let g:php_cs_fixer_config = "sf23" 


let g:neocomplete#enable_at_startup = 1

function! IPhpInsertUse()
  call PhpInsertUse()
  call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <leader>u :call PhpInsertUse()<CR>

autocmd FileType php inoremap <Leader>s <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>s :call PhpSortUse()<CR>

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
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
