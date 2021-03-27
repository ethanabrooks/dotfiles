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
"Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'morhetz/gruvbox'
Plug 'ervandew/supertab'
Plug 'keith/swift.vim'
Plug 'mattn/emmet-vim'
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
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
