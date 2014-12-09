" vim: tabstop=2
" vim: expandtab

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'taglist.vim'
Plugin 'dbext.vim'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-cucumber.git'
Plugin 'VimClojure'
Plugin 'pangloss/vim-javascript'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'tpope/vim-markdown'
Plugin 'groenewege/vim-less'
call vundle#end()

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
map <F3> :TlistToggle<CR>
map <C-j> :GitGutterNextHunk<CR>
map <C-k> :GitGutterPrevHunk<CR>

augroup vimrcEx
au!
" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78
" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
augroup END

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

