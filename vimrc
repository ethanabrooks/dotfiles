scriptencoding utf-8
set encoding=utf-8

nnoremap <leader>w :w<CR>
nnoremap <C-w> :close<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-c> :.!pbcopy<CR>k:r !pbpaste<CR>
nnoremap <C-t> :TagbarToggle<CR>

" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set noswapfile    "
set history=50
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

call plug#begin('~/.vim/bundle')

" Define bundles via Github repos
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


call plug#end()

"aesthetics
set background=light
colorscheme PaperColor


filetype plugin indent on
" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

"au BufWrite * :Autoformat

" spell-check markdown
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.md nnoremap k gk
autocmd BufRead,BufNewFile *.md nnoremap j gj
autocmd BufRead,BufNewFile *.md nnoremap gk k
autocmd BufRead,BufNewFile *.md nnoremap gj j
autocmd BufRead,BufNewFile *.mjcf setf xml


" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep!  <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Make it obvious where 80 characters is
"set textwidth=80
"set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

"execute this file
nnoremap <C-x> :execute "!./" . expand('%:t')<CR>
"execute last command
nnoremap <leader>x :<up><CR>
"save
nnoremap <leader>w :w<CR>
"easy source virmc
command! Sovim source $MYVIMRC
"easy update plugins
command! Replug source $MYVIMRC | PlugUpgrade | PlugClean | PlugInstall
"delete trailing whitespace
command! Despace %s/\s\+\n/\r/g


let $BUNDLES = "~/.vimrc.bundles.local"

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'
let g:syntastic_haskell_checkers = ['hlint']
let g:syntastic_python_checkers = ['flake8']
let g:jedi#force_py_version = 3
let g:loaded_python_provider = 1

set t_Co=256
set guifont="Droid Sans Mono":h14

let $PATH .= ':' . '$HOME/.local/bin/'


"merlin for OCaml
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')

function! Hashbang(portable, permission, RemExt)
  let shells = {
        \    'awk': "awk",
        \     'sh': "bash",
        \     'hs': "stack",
        \     'jl': "julia",
        \    'lua': "lua",
        \    'mak': "make",
        \     'js': "node",
        \      'm': "octave",
        \     'pl': "perl",
        \    'php': "php",
        \     'py': "python",
        \      'r': "Rscript",
        \     'rb': "ruby",
        \  'scala': "scala",
        \    'tcl': "tclsh",
        \     'tk': "wish",
        \  'swift': "swift"
        \    }

  let extension = expand("%:e")

  if has_key(shells,extension)
    let fileshell = shells[extension]

    if a:portable
      let line =  "#! /usr/bin/env " . fileshell
    else
      let line = "#! " . system("which " . fileshell)
    endif

    0put = line

    if a:permission
      :autocmd BufWritePost * :autocmd VimLeave * :!chmod u+x %
    endif


    if a:RemExt
      :autocmd BufWritePost * :autocmd VimLeave * :!mv % "%:p:r"
    endif

  endif

endfunction

autocmd BufRead,BufNewFile ~/dotfiles/*/config setfiletype dosini
autocmd BufNewFile *.* :call Hashbang(1,1,0)

au BufReadPost *.julius set syntax=javascript
au BufReadPost *.hamlet set syntax=html

" vim-hdevtools
autocmd BufRead *.hs :let &makeprg='hdevtools check %'
" haskell-vim
let g:haskell_classic_highlighting  = 1
"let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
"let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
"let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
"let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
"let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
"let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
"let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
