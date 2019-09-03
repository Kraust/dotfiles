call plug#begin('~/.local/share/nvim/plugged')

		" -- Required for neovim-qt:
		Plug 'equalsraf/neovim-gui-shim'

		" -- Other plugins
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'

		Plug 'joshdick/onedark.vim'

call plug#end()

set termguicolors
syntax on
colorscheme onedark

set clipboard+=unnamedplus
set mouse=a
set noshowmode
set noshowcmd
set lazyredraw
set regexpengine=1
set nowrap
set hlsearch
set number
set laststatus=1
set splitbelow
set splitright
set list
set wildmenu

set tabstop=4
set shiftwidth=4
set smarttab
set noexpandtab

set nobackup
set nowritebackup
set noswapfile

nnoremap d "_d
vnoremap d "_d

nnoremap Q <Nop>

tnoremap <S-Backspace> <Backspace>
tnoremap <C-Backspace> <Backspace>

" -- Tab Cycling
nnoremap <silent> <Tab> :bn<cr>
nnoremap <silent> <S-Tab> :bp<cr>
nnoremap <silent> <M-Left> :tabpreviou<cr>
nnoremap <silent> <M-Right> :tabnext<cr>


nnoremap <silent> <C-Up> <C-W>k
nnoremap <silent> <C-Down> <C-W>j
nnoremap <silent> <C-Left> <C-W>h
nnoremap <silent> <C-Right> <C-W>l

tnoremap <Esc> <C-\><C-n>

" -- file in clipboard
nnoremap <leader>c :let @+ = expand("%:p")<cr>

" Auto Resie splits
autocmd VimResized * wincmd =

nnoremap <silent> <leader>t :term<cr>

autocmd TermOpen * setlocal nonumber bufhidden=hide

