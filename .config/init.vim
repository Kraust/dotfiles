call plug#begin('~/.local/share/nvim/plugged')

        " -- Required for neovim-qt:
        Plug 'equalsraf/neovim-gui-shim'

        " -- Other plugins
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
        Plug 'lambdalisue/gina.vim'
        Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
        Plug 'rhysd/git-messenger.vim'

        " -- Theming
        Plug 'NLKNguyen/papercolor-theme'
        Plug 'NLKNguyen/c-syntax.vim'
        Plug 'sonph/onehalf', {'rtp': 'vim/'}
        Plug 'lucasprag/simpleblack'

        " -- Language Server
        Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
        Plug 'ncm2/ncm2'
        Plug 'roxma/nvim-yarp'
        Plug 'SirVer/ultisnips'
        Plug 'ncm2/ncm2-ultisnips'
        Plug 'honza/vim-snippets'

"        Plug 'Kraust/floater.nvim'

call plug#end()

source /home/kraust/git/floater.nvim/plugin/floater.vim

set termguicolors
"set background=dark
colorscheme PaperColor
"colorscheme simpleblack
syntax on

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
"set cursorline
set list
set wildmenu

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab "Can't use this when working with C.

set guifont=Fira\ Code:h8

function SetIndentC()
        set tabstop=8
        set shiftwidth=8
        set noexpandtab
endfunction()

augroup INDENT
        autocmd!
        autocmd FileType cpp,c call SetIndentC()
augroup END

" -- Remap Delete to use the black hole register.
nnoremap d "_d
vnoremap d "_d

" -- Remap Ex-Mode because it's trash and next to tab.
nnoremap Q <Nop>

" -- FIXME: Once I can use --servername create a bug for this:
tnoremap <S-Backspace> <Backspace>
tnoremap <C-Backspace> <Backspace>

" -- Tab Cycling
nnoremap <silent> <Tab> :bn<cr>
nnoremap <silent> <S-Tab> :bp<cr>
nnoremap <silent> <M-Left> :tabpreviou<cr>
nnoremap <silent> <M-Right> :tabnext<cr>

" -- Remap exiting a terminal to Esc. 
" -- This prevents vim inside of vim
tnoremap <Esc> <C-\><C-n>

" -- Spacing fixers
nnoremap <leader>s :Gina status<cr>
nnoremap <leader>t :terminal<cr>
vnoremap <leader>r :retab!<cr>
vnoremap <leader>8 :s/\t/        /g<cr>
vnoremap <leader>4 :s/\t/    /g<cr>
vnoremap <leader>2 :s/\t/  /g<cr>

" -- file in clipboard
nnoremap <leader>c :let @+ = expand("%:p")<cr>

" Auto Resie splits
autocmd VimResized * wincmd =

" Terminal setup
autocmd TermOpen * setlocal nonumber bufhidden=hide

" Boilerplate
autocmd BufNewFile *.c 0r ~/share/boilerplate/boilerplate.c
autocmd BufNewFile *.cpp 0r ~/share/boilerplate/boilerplate.c
autocmd BufNewFile *.cc 0r ~/share/boilerplate/boilerplate.c
autocmd BufNewFile *.h 0r ~/share/boilerplate/boilerplate.h

" -- git-messenger specific.
" git-messenger {{{
let g:git_messenger_no_default_mappings=v:true
nmap <Leader>m <Plug>(git-messenger)
" }}}

" == Here Be Language Servers
inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"

let g:LanguageClient_autoStart = 1
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_serverCommands = {
\        'c': ['ccls', '--log-file=/tmp/ccls_c.log'],
\        'cpp': ['ccls', '--log-file=/tmp/ccls_cpp.log'],
\        'go': ['gopls'],
\        'python': ['pyls'],
\}

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noinsert,noselect

inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" -- ExpandTrigger default conflicts with pum movement
let g:UltiSnipsExpandTrigger = '<Plug>(placeholder)'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = '~/UltiSnips'
let g:UltiSnipsSnippetDirectories=["/home/kraust/UltiSnips", "UltiSnips"]

function SetLSPShortcuts()
        nnoremap <leader>ld :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
        nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
        nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
        nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
        nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
        nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
        nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
        nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
        nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
        nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
        autocmd!
        autocmd FileType cpp,c,go call SetLSPShortcuts()
augroup END

call gina#custom#command#option('status', '--opener', 'FloaterNew')

