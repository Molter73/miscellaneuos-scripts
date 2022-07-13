" Options
" Enables the clipboard between Vim/Neovim and other applications.
set clipboard=unnamedplus
" Modifies the auto-complete menu to behave more like an IDE.
set completeopt=noinsert,menuone,noselect
set shortmess+=c
set cursorline " Highlights the current line in the editor
set hidden " Hide unused buffers
set autoindent " Indent a new line
set autoread " Read buffers modified outside of Neovim
set inccommand=split " Show replacements in a split screen
set mouse=a " Allow to use the mouse in the editor
set number " Shows the line numbers
set splitbelow splitright " Change the split screen behavior
set title " Show file title
set wildmenu " Show a more advance menu
set cc=80 " Show at 80 column a border for good code style
set shiftwidth=4 tabstop=4 expandtab " Tabs are now 4 space wide
set scrolloff=8
set signcolumn=yes
set relativenumber
set nu
filetype plugin indent on   " Allow auto-indenting depending on file type
syntax on
" set spell " enable spell check (may need to download language package)
set ttyfast " Speed up scrolling in Vim
set list lcs=tab:==>,trail:·,precedes:<,extends:>,multispace:·,nbsp:○
set updatetime=200
let mapleader = ","
set nohls

call plug#begin()

" Nightfly theme
Plug 'bluz71/vim-nightfly-guicolors'

" nvim LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Python jedi
Plug 'davidhalter/jedi-vim'

" Lualine
Plug 'nvim-lualine/lualine.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope.nvim'

" GitGutter
Plug 'airblade/vim-gitgutter'

" Git Blamer
Plug 'APZelos/blamer.nvim'

call plug#end()

set background=dark
set termguicolors
colorscheme nightfly

function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    keeppatterns %s/\n*\%$//
    call winrestview(l:save)
  endif
endfun

augroup MOLTER
    autocmd!
    autocmd FileType * autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END
