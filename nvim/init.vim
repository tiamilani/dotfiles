" If there is a init.vim in when executing nvim . it will source it
set exrc
" Always keep the cursor as a block
set guicursor=

" Relative numbers on the left
set relativenumber
" Show the current line number
set nu

" No highlight search
set nohlsearch
" Highlight while searching
set incsearch

" Keeps extra buffers in background and going awey without saving it
set hidden

" No sounds
set noerrorbells

" No wrapping when going over the limit
set nowrap

" To look forward
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Tab of 4 spaces
set tabstop=4
set smartindent

" Scroll a number of line before the end of the visual section
set scrolloff=8

" Left column, useful for linting
set signcolumn=yes
" 80 character column
set colorcolumn=80

" Plugins
call plug#begin('~/nvim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')                                                                                          
    let g:rg_derive_root='true'                                                                              
endif                                                                                                        
                                                                                                             
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']  
