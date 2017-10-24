" vim: tabstop=2
" vim: expandtab

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'rking/ag.vim'
Plug 'osyo-manga/vim-over'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/syntastic'
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
Plug 'derekwyatt/vim-scala'
Plug 'chaquotay/ftl-vim-syntax'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'kylef/apiblueprint.vim'
Plug 'groenewege/vim-less'
Plug 'rodjek/vim-puppet'
Plug 'mustache/vim-mustache-handlebars'
Plug 'powerman/vim-plugin-AnsiEsc', { 'on': 'AnsiEsc' }
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
call plug#end()

colorscheme elflord
highlight LineNr ctermfg=60
set hlsearch
set ignorecase
set smartcase
set number
set relativenumber
map Q gq
map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>
map <C-j> :GitGutterNextHunk<CR>
map <C-k> :GitGutterPrevHunk<CR>

nnoremap <Enter> :OverCommandLine<CR>
vnoremap <Enter> :OverCommandLine<CR>
nnoremap <BS> :nohlsearch<CR>
nnoremap <F4> :OverCommandLine<CR>%s//gc<Left><Left><Left>
nnoremap <S-F4> :OverCommandLine<CR>%s/<C-r><C-w>//gc<Left><Left><Left>

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
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

"
" you complete me
"
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist = {}

"
" ctrlp
"
let g:ctrlp_by_filename = 0
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
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

" syntastic java check is too slow
let g:syntastic_ignore_files = ['\.java$']
