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
filetype plugin indent on   " Allow auto-indenting depending on file type
syntax on
" set spell " enable spell check (may need to download language package)
set ttyfast " Speed up scrolling in Vim
set list lcs=tab:=>\ ,trail:·,precedes:<,extends:>,multispace:·,nbsp:○
set updatetime=200
let mapleader = ","

source $HOME/.config/nvim/plugins.vim

set background=dark
set termguicolors
colorscheme nightfly

source $HOME/.config/nvim/modules/lsp-config.vim
source $HOME/.config/nvim/modules/lualine.vim
source $HOME/.config/nvim/modules/blamer.vim
source $HOME/.config/nvim/modules/telescope.vim

" Remappings
map <esc> :noh <CR>
