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
Plug 'w0rp/ale'                          "
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'dhruvasagar/vim-table-mode'
"Plug 'taglist.vim'
"Plug 'dbext.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-cucumber'
Plug 'tfnico/vim-gradle'
"Plug 'VimClojure'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'jparise/vim-graphql'
"Plug 'derekwyatt/vim-scala'
"Plug 'chaquotay/ftl-vim-syntax'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-markdown'
"Plug 'suan/vim-instant-markdown'
Plug 'kylef/apiblueprint.vim'
Plug 'groenewege/vim-less'
Plug 'rodjek/vim-puppet'
Plug 'glench/vim-jinja2-syntax'
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
map <F1> <nop>
imap <F1> <nop>
map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>
map <C-j> :GitGutterNextHunk<CR>
map <C-k> :GitGutterPrevHunk<CR>

nnoremap <Enter> :OverCommandLine<CR>
vnoremap <Enter> :OverCommandLine<CR>
nnoremap <F4> :OverCommandLine<CR> %s/<C-r><C-w>//Ig<Left><Left><Left>
nnoremap <BS> :nohlsearch<CR>

nnoremap H <C-o> " Browse code like you're using vimium back button
nnoremap L <C-i> " Browse code like you're using vimium forward button

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
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l -g ""
      \ --hidden
      \ --skip-vcs-ignores
      \ --ignore .git
      \ --ignore node_modules
      \ --ignore vendor
      \ --ignore _site
      \ --ignore .sass-cache
      \ --ignore target
      \ --ignore target-eclipse
      \ --ignore "*.swp"
      \ --nocolor'


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

let g:syntastic_sh_shellcheck_args="-x"

" default ragtag maps
let g:ragtag_global_maps = 1

"
" table mode
"
let g:table_mode_corner = '|'

