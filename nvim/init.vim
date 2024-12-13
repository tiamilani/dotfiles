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
set noexpandtab
set tabstop=8
set nosmarttab
set autoindent
" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost *
	\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Scroll a number of line before the end of the visual section
set scrolloff=8

" Left column, useful for linting
set signcolumn=yes
" 80 character column
set colorcolumn=80

" Spell checker
set spelllang=en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Update time
set updatetime=300

" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'beauwilliams/statusline.lua'
" autocompleate
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Python doc generator
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
" Automatic double quotes
Plug 'jiangmiao/auto-pairs'
" Multiple automation tool
Plug 'neomake/neomake'
" fugitive for git integration
Plug 'tpope/vim-fugitive'
" Game
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'lewis6991/gitsigns.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', {'tag': '3.26'}

Plug 'lervag/vimtex', { 'tag': 'v2.15' }
call plug#end()

colorscheme gruvbox-baby
set background=dark

lua <<EOF
local statusline = require('statusline')
statusline.tabline = false
EOF

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let mapleader = " "

" Configure the commenter
lua require('Comment').setup()

" Configure neo-tree
lua require('_neo-tree')
nnoremap <leader>e :Neotree toggle<CR>

" in visual mode remap p to substitute what is currently select with the
" current copied buffer
vnoremap p "_dP

" movements
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>s <C-w><C-x>
nnoremap <leader><TAB> gt
nnoremap <leader><S-Tab> gT

" COQ
let g:coq_settings = { 'auto_start': v:true }

" 🐓 Coq completion settings

" Set recommended to false
let g:coq_settings = { "keymap.recommended": v:false }

" Keybindings
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
" ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
ino <silent><expr> <space> pumvisible() ? (complete_info().selected == -1 ? "\<C-e><space>" : "\<C-y>") : "\<space>"
ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

" skeletons
nnoremap ,pymain :-1read $HOME/.config/nvim/skeletons/skeleton.python_main<CR>
nnoremap ,pyclass :-1read $HOME/.config/nvim/skeletons/skeleton.python_class<CR>
nnoremap ,pyargs :-1read $HOME/.config/nvim/skeletons/skeleton.python_args<CR>
nnoremap ,mfunction :-1read $HOME/.config/nvim/skeletons/skeleton.matlab_function<CR>

" YCM
" nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
" nnoremap <silent> <leader>gf :YcmCompleter GoToReferences<CR>
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files prompt_prefix=🔍<cr>
nnoremap <leader>faf <cmd>Telescope find_files no_ignore=true prompt_prefix=🔍<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fgs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>tGc <cmd>Telescope git_commits<cr>
nnoremap <leader>tGs <cmd>Telescope git_status<cr>

lua require('_telescope')
lua vim.keymap.set('n', '*', '*zz', {desc = 'Search and center screen'})
lua vim.keymap.set('n', 'n', 'nzz', {desc = 'Search next and center screen'})
lua vim.keymap.set('n', 'N', 'Nzz', {desc = 'Search previous and center screen'})

" bufferline
set termguicolors
lua << EOF
require("bufferline").setup{
	options = {
		mode = "tabs",
		numbers = "ordinal",
		separator_style="slope"
	}
}
EOF

" Pydocstring
nnoremap <leader>pd <cmd>Pydocstring<cr>
nnoremap <leader>PD <cmd>PydocstringFormat<cr>
let g:pydocstring_formatter = 'numpy'
let g:pydocstring_doq_path = '/home/mattia/.local/bin/doq'

" Fugitive
"nnoremap <leader>gs <cmd>Git<CR>

" auto pairs
au FileType vim let b:AutoPairs = AutoPairsDefine({})

" Neomake linteger
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrw', 50)

" treesitter conf install every module
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "bash", "c", "jsonc", "latex", "bibtex", "dockerfile", "lua", "vim", "matlab"},
  highlight = {
    enable = true,
	disable={ "latex", "bibtex" },
  },
}
EOF

let g:python3_host_prog = '/usr/bin/python3.10'

let g:mkdp_port = '54321'
let g:mkdp_open_to_the_world = 1

" Linux coding style for DPDK project
let g:linuxsty_patterns = ["/home/mattia/src/lookaside-nnar/dpdk/dpdk-24.03/examples/eCPRI_decoder"]

" Copilot basic options
set completeopt+=noinsert
imap <silent> <C-Space> <Plug>(copilot-suggest)
" M- stands for the left alt key
imap <silent> <M-.> <Plug>(copilot-next)
imap <silent> <M-,> <Plug>(copilot-previous)
imap <silent> <C-W> <Plug>(copilot-accept-word)
"vim.keymap.set('i', '<C-W>', '<Plug>(copilot-accept-word)')
"vim.keymap.set("i", "<C-Tab>", "copilot#Next()", {expr=true, silient=true})
"vim.keymap.set("i", "<C-S-Tab>", "copilot#Previous()", {expr=true, silient=true})
"vim.keymap.set('i', '<C-Space>', "copilot#sugest()", {expr=true, silent=true})

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

fun! SpellCheck()
		set spell
endfun

let g:mkdp_auto_close = 0

let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_compiler_progname = 'nvr'

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

augroup TIA
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
	autocmd BufWritePre *.tex :call SpellCheck()
    " Setup formatexpr specified filetype(s).
    " autocmd FileType python,yaml,json,matlab setl formatexpr=CocAction('formatSelected')
augroup END
