-- Options
-- Enables the clipboard between Vim/Neovim and other applications.
vim.opt.clipboard = 'unnamedplus'
-- Modifies the auto-complete menu to behave more like an IDE.
vim.opt.completeopt = 'noinsert,menuone,noselect'
vim.opt.shortmess:append('c')
vim.opt.cursorline = true -- Highlights the current line in the editor
vim.opt.hidden = true -- Hide unused buffers
vim.opt.autoindent = true -- Indent a new line
vim.opt.autoread = true -- Read buffers modified outside of Neovim
vim.opt.inccommand = 'split' -- Show replacements in a split screen
vim.opt.mouse = 'a' -- Allow to use the mouse in the editor
vim.opt.number = true -- Shows the line numbers
vim.opt.splitbelow = true -- Change the split screen behavior
vim.opt.title = true -- Show file title
vim.opt.wildmenu = true -- Show a more advance menu
vim.opt.cc = '80' -- Show at 80 column a border for good code style
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true -- Tabs are now 4 space wide
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.relativenumber = true
vim.opt.ttyfast = true -- Speed up scrolling in Vim
vim.opt.list = true
vim.opt.listchars = {
    tab = '==>',
    trail = '·',
    precedes = '<',
    extends = '>',
    multispace = '·',
    nbsp = '○',
}
vim.opt.updatetime = 200
vim.opt.hls = false
vim.g.mapleader = ' '

local Plug = vim.fn['plug#']

vim.cmd('call plug#begin()')

-- Nightfly theme
Plug('bluz71/vim-nightfly-guicolors')

-- nvim LSP
Plug('neovim/nvim-lspconfig')
Plug('williamboman/nvim-lsp-installer')

-- Completion framework
Plug('hrsh7th/nvim-cmp')

-- LSP completion source for nvim-cmp
Plug('hrsh7th/cmp-nvim-lsp')

-- Snippet completion source for nvim-cmp
Plug('hrsh7th/cmp-vsnip')

-- Other usefull completion sources
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-buffer')

-- See hrsh7th's other plugins for more completion sources!

-- To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug('simrat39/rust-tools.nvim')

-- Snippet engine
Plug('hrsh7th/vim-vsnip')

-- Python jedi
Plug('davidhalter/jedi-vim')

-- Lualine
Plug('nvim-lualine/lualine.nvim')

-- Telescope
Plug('nvim-lua/plenary.nvim')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = vim.fn['cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'] })
Plug('nvim-telescope/telescope.nvim')

-- GitGutter
Plug('airblade/vim-gitgutter')

-- Git Blamer
Plug('APZelos/blamer.nvim')

-- Markdown preview
Plug('iamcco/markdown-preview.nvim', { ['do'] = vim.fn['cd app && yarn install'] })

vim.cmd('call plug#end()')

vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.cmd('colorscheme nightfly')

local trim_whitespace = function()
    local ft = vim.bo.filetype

    if ft == 'diff' or ft == 'binary' then
        return
    end

    local view_save = vim.fn.winsaveview()
    vim.cmd([[
        keeppatterns %s/\s\+$//e
        keeppatterns %s/\n*\%$//
    ]])
    vim.fn.winrestview(view_save)
end

local molter = vim.api.nvim_create_augroup('MOLTER', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    group = molter,
    callback = trim_whitespace,
})

-- Remaps
vim.api.nvim_set_keymap('n', '<Leader>ej', '<cmd>Ex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>ev', '<cmd>Vex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>eh', '<cmd>Sex<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>md', '<cmd>MarkdownPreview<CR>', {noremap = true})
