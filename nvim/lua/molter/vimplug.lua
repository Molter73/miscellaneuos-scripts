-- Install all plugins
local Plug = vim.fn['plug#']

vim.cmd('call plug#begin()')

-- Nightfly theme
Plug('bluz71/vim-nightfly-guicolors')

-- Catpuccin theme
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })

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

-- Lualine
Plug('nvim-lualine/lualine.nvim')

-- Telescope
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim',
    { ['do'] = vim.fn[
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        ] })
Plug('nvim-telescope/telescope.nvim')

-- GitGutter
Plug('airblade/vim-gitgutter')

-- Markdown preview
Plug('iamcco/markdown-preview.nvim', { ['do'] = vim.fn['cd app && yarn install'] })

-- treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn[':TSUpdate'] })
Plug('nvim-treesitter/nvim-treesitter-context')

-- duck!
-- Plug('tamton-aquib/duck.nvim')

vim.cmd('call plug#end()')
