filetype plugin indent on
 
"{{{ au FileType
au FileType vim set foldmethod=marker
au FileType markdown setlocal spell
au FileType markdown nnoremap k gk
au FileType markdown nnoremap j gj
au FileType markdown nnoremap gk k
au FileType markdown nnoremap gj j
au FileType julius set syntax=javascript
au FileType hamlet set syntax=html
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
"}}}
"
"{{{ let
let mapleader = " "
let $PATH .= ':' . '$HOME/.local/bin/'
let g:syntastic_check_on_open=1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_haskell_checkers = ['hlint', 'hdevtools']
let g:syntastic_tex_checkers = ['lacheck']

" jedi-vim
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog  = '/usr/bin/python3'

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
"}}}

"{{{ nnoremap
nnoremap <leader>w :w<CR>
nnoremap <C-w> :close<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-c> :.!pbcopy<CR>k:r !pbpaste<CR>
nnoremap <C-t> :TagbarToggle<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"execute this file
nnoremap <C-x> :execute "!./" . expand('%:t')<CR>

"execute last command
nnoremap <leader>x :<up><CR>

"save
nnoremap <leader>w :w<CR>
"}}}

"{{{ plug
call plug#begin('~/.vim/bundle')
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
call plug#end()
"}}}

"{{{ set
set t_Co=256
set guifont="Droid Sans Mono":h14

set noswapfile
set incsearch     " incremental searching
set autowrite     " :write before leaving file
set background=light 
set tabstop=2 " show existing tab with 2 spaces width
set shiftwidth=2 " when indenting with '>', use 2 spaces width 
set expandtab " On pressing tab, insert 2 spaces
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set number
set numberwidth=1
set complete+=kspell " Autocomplete with dictionary words when spell check is on
set cursorline
set wildmenu
set lazyredraw  " maybe faster with macros

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
"}}}

"{{{ Use The Silver Searcher for CtrlP
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
 "}}}

"{{{ command!
"easy source virmc
command! Sovim source $MYVIMRC
"easy update plugins
command! Replug source $MYVIMRC | PlugUpgrade | PlugClean | PlugInstall
"delete trailing whitespace
command! Despace %s/\s\+\n/\r/g
"}}}

"{{{ Hashbang
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
autocmd BufNewFile * :call Hashbang(1,0,0)
"}}}

colorscheme PaperColor
