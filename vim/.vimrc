" vim: tabstop=2
" vim: expandtab

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'gmarik/Vundle.vim'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'rking/ag.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'taglist.vim'
Plug 'dbext.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-cucumber'
Plug 'tfnico/vim-gradle'
Plug 'VimClojure'
Plug 'pangloss/vim-javascript'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-markdown'
Plug 'groenewege/vim-less'
call plug#end()

colorscheme elflord
filetype plugin indent on
syntax on
set laststatus=2
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch
set hlsearch
set tabstop=4
set expandtab
map Q gq
inoremap <C-U> <C-G>u<C-U>
map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>
map <F4> :TlistToggle<CR>
map <C-j> :GitGutterNextHunk<CR>
map <C-k> :GitGutterPrevHunk<CR>

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78
" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

"
" vim airline
"
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

"
" you complete me
"
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1

"
" ctrlp
"
let g:ctrlp_by_filename = 1
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s
    \  -type f
    \  -not -path "*/target/*"
    \  -not -name "*.pyc"
    \  -not -name "*.class"
    \  -not -name "*.jar"
    \'
  \ }

"
" dbext
"
let g:dbext_default_profile_keeper_local = 'type=mysql:user=keeper_keeperbas:passwd=keeper_keeperbas:dbname=keeper_keeperbase'
"let g:dbext_default_profile_sqlite = 'type=sqlite:dbname=db.sqlite'
let g:dbext_default_profile = 'keeper_local'

"
" vim clojure
"
let vimclojure#ParenRainbow=1

