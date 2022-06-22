call plug#begin('~/.vim/plugged')
Plug 'terryma/vim-smooth-scroll'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
Plug 'ekalinin/Dockerfile.vim', {'for': 'docker'}
Plug 'morhetz/gruvbox'
Plug 'ervandew/supertab'
Plug 'keith/swift.vim'
Plug 'mattn/emmet-vim'
Plug 'cespare/vim-toml'
Plug 'LnL7/vim-nix'
Plug 'PeterMitrano/urdf-vim'
call plug#end()

augroup filetypes
  autocmd!
  au FileType markdown setlocal spell
  au FileType markdown nnoremap k gk
  au FileType markdown nnoremap j gj
  au FileType markdown nnoremap gk k
  au FileType markdown nnoremap gj j
  au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
  au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
  au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
  au FileType *.toml setfiletype dosini
  au FileType *.tsx setfiletype typescript
augroup END

let mapleader = " "

let g:ale_fixers = {'python': ['black'], 'markdown': ['prettier'], 'tex': ['latexindent'], 'yaml': ['yapf'], 'ocaml': ['ocamlformat'], 'javascript': ['prettier'], 'haskell': ['brittany', 'hlint'], 'rust': ['rustfmt'], 'typescript': ['prettier'], 'json': ['prettier'], 'html': ['prettier'], 'css': ['prettier'] }
"let g:ale_linters = {'python': ['mypy', 'pyls'], 'tex': ['lacheck'], 'ocaml': ['merlin'], 'haskell': ['stack-ghc'], 'css': ['prettier']}
"let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_python_pyls_auto_pipenv = 1
let g:ale_rust_rls_toolchain = 'stable'
"let g:vimtex_view_method = 'skim'

nnoremap <leader>w :w<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-p> :Files<CR>
nnoremap <leader>b Obreakpoint()<ESC>

set noswapfile
set expandtab
set number "line numbers

colorscheme gruvbox
