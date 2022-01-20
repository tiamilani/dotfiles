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

" Update time
set updatetime=300

" Plugins
call plug#begin('~/.config/nvim/plugged')

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
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Python doc generator
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
" Automatic double quotes
Plug 'jiangmiao/auto-pairs'
" Comment lines with <leader>cc de comment them with <leader>cu
Plug 'preservim/nerdcommenter'
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

" Configure the nerdcommenter
filetype plugin on
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 0
" Remember to use <leader>c<space>

" movements
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" skeletons
nnoremap ,pymain :-1read $HOME/.config/nvim/skeletons/skeleton.python_main<CR>
nnoremap ,pyclass :-1read $HOME/.config/nvim/skeletons/skeleton.python_class<CR>

" YCM
" nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
" nnoremap <silent> <leader>gf :YcmCompleter GoToReferences<CR>
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1

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

" pydock
let g:pydocstring_doq_path = '/home/mattia/.local/bin/doq'

" Neomake linteger
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrw', 50)

" treesitter conf install every module
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "bash", "c", "jsonc", "latex", }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

" Coc configurations
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" GoTo code navigation.
nnoremap <silent> <leader>gd <Plug>(coc-definition)
nnoremap <silent> <leader>gy <Plug>(coc-type-definition)
nnoremap <silent> <leader>gi <Plug>(coc-implementation)
nnoremap <silent> <leader>gr <Plug>(coc-references)

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
    " Setup formatexpr specified filetype(s).
    autocmd FileType python,yaml,json setl formatexpr=CocAction('formatSelected')
augroup END

