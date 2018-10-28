set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    " Let dein manage dein
    " Required:
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here:
    call dein#add('VundleVim/Vundle.vim')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('chriskempson/base16-vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('ludovicchabant/vim-gutentags')
    call dein#add('rhysd/vim-clang-format')
    call dein#add('fatih/vim-go')
    call dein#add('tpope/vim-tbone')
    call dein#add('qpkorr/vim-bufkill')

    " Deoplete
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('zchee/deoplete-go', {'build' : 'make'})
    call dein#add('zchee/deoplete-clang')
    call dein#add('wsdjeg/dein-ui.vim')

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

set noshowmode

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set nowrap
set hlsearch
set number
set mouse=a

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Splits the "right" way.
set splitbelow
set splitright

highlight LineNr ctermbg=NONE
set cursorline

set t_ut=

" Remap Delete to not cut.
nnoremap d "_d
vnoremap d "_d

" Remap Ex-Mode because it's trash and next to tab.
nnoremap Q <Nop>

" Tab Cycling
nnoremap <silent> <Tab> :bn<cr>
nnoremap <silent> <S-Tab> :bp<cr>

" Custom Commands
:command JqFormat execute "%!jq \".\""
:command JqMinify execute "%!jq -c \".\""
:command AutoUpdate execute ':set autoread | au CursorHold * checktime | call feedkeys("lh")'

"" airline config
let g:airline_section_z ="%3l/%L:%2v"
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#left_sep = ""
let g:airline#extensions#bufferline#right_sep = ""
let g:airline#extensions#bufferline#left_alt_sep = ""
let g:airline#extensions#bufferline#right_alt_sep = ""
let g:airline#extensions#tabline#left_sep = " "
let g:airline#extensions#tabline#right_sep = ""
let g:airline#extensions#tabline#left_alt_sep = ""
let g:airline#extensions#tabline#right_alt_sep = ""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#ale#enabled = 1

" Enable clang-autoformat by default
"autocmd FileType c,cpp ClangFormatAutoEnable

" This is all for asyncrun.vim
let g:asyncrun_open = 8
let g:asyncrun_status = ''
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

set timeoutlen=100 ttimeoutlen=0

autocmd VimResized * wincmd =
set clipboard=unnamedplus

" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

" Path to python interpreter for neovim
let g:python3_host_prog  = '/usr/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1
" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']


"hi Normal guibg=NONE ctermbg=NONE
