scriptencoding utf-8
set encoding=utf-8
filetype plugin indent on
 
"{{{ au FileType
augroup filetypes
autocmd!
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
au BufRead,BufNewFile *.mjcf setfiletype xml
autocmd BufNewFile,BufRead .pyre_configuration set syntax=json
augroup END
"}}}

"{{{ let
let mapleader = " "
let $PATH = '/usr/bin:' . $PATH . ':' . '$HOME/.local/bin/'
"let g:syntastic_check_on_open=1
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'
"let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_haskell_checkers = ['hlint', 'hdevtools']

" jedi-vim
let g:python_host_prog  = '/home/ethanbro/virtualenvs/neovim2/bin/python'
let g:python3_host_prog  = '/home/ethanbro/virtualenvs/neovim/bin/python'

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

let g:ale_fixers = ['yapf', 'isort']
let g:ale_linters = {'python': ['pylint', 'pyls']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_python_pyls_auto_pipenv = 1

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

"let g:pymode_options_max_line_length = 90
"let g:pymode_python = 'python3'
"let g:pymode_rope = 1
"let g:pymode_rope_autoimport=1
"}}}

"{{{ nnoremap
nnoremap <leader>w :w<CR>
nnoremap <C-w> :close<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <F4> :Autoformat<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"execute this file
"nnoremap <C-x> :execute "!./" . expand('%:t')<CR>

"execute last command
nnoremap <leader>x :<up><CR>

"save
nnoremap <leader>w :w<CR>

" fzf
nnoremap <C-p> :Files<CR>

" break
nnoremap <leader>b Oimport ipdb; ipdb.set_trace()<ESC>

nnoremap <leader>k :ALEPrevious<CR>
nnoremap <leader>j :ALENext<CR>
"}}}

"{{{ plug
call plug#begin('~/.vim/bundle')
if filereadable(expand("~/.config/nvim/bundles.vim"))
  source ~/.config/nvim/bundles.vim
endif
call plug#end()
"}}}

colorscheme gruvbox
