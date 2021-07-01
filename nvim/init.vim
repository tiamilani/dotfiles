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

" Spell checker
set spelllang=en

" Plugins
call plug#begin('~/nvim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Remember C-v to split vertically, C-x split, C-x for tab
Plug 'nvim-telescope/telescope.nvim'
" We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Powerline bar
Plug 'vim-airline/vim-airline'
" airline themes
Plug 'vim-airline/vim-airline-themes'
" You complete me
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Python doc generator
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
" Automatic double quotes
Plug 'jiangmiao/auto-pairs'
" Comment lines with <leader>cc de comment them with <leader>cu
Plug 'scrooloose/nerdcommenter'
" floding, buggy
" Plug 'tmhedberg/SimpylFold'
" Multiple automation tool
Plug 'neomake/neomake'
" fugitive for git integration
Plug 'tpope/vim-fugitive'
" Game
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let mapleader = " "

" muvements
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" YCM
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter GoToReferences<CR>
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope grep_string<cr>
nnoremap <leader>flg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>tgc <cmd>Telescope git_commits<cr>
nnoremap <leader>tgs <cmd>Telescope git_status<cr>

" Pydocstring
nnoremap <leader>pd <cmd>Pydocstring<cr>
nnoremap <leader>PD <cmd>PydocstringFormat<cr>
let g:pydocstring_formatter = 'numpy'

" Fugitive
nnoremap <leader>gs <cmd>Git<CR>

" auto pairs
au FileType vim let b:AutoPairs = AutoPairsDefine({})

" SimplyFold
" let g:SimpylFold_docstring_preview = 1

" Neomake linteger
let g:neomake_python_enabled_makers = ['flake8']
call neomake#configure#automake('nrwi', 500)

" treesitter conf install every module
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "bash", "c", "jsonc", "latex", }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

fun! SpellCheck()
   set spell
endfun

augroup TIA
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
	autocmd BufWritePre *.tex :call SpellCheck()
augroup END

