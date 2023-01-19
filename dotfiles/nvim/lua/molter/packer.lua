return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Catpuccin theme
    use { 'catppuccin/nvim', as = 'catppuccin' }

    -- nvim LSP
    use { 'neovim/nvim-lspconfig' }
    use { 'williamboman/nvim-lsp-installer' }

    -- Completion framework
    use { 'hrsh7th/nvim-cmp' }

    -- LSP completion source for nvim-cmp
    use { 'hrsh7th/cmp-nvim-lsp' }

    -- Snippet completion source for nvim-cmp
    use { 'hrsh7th/cmp-vsnip' }

    -- Other usefull completion sources
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-buffer' }

    -- See hrsh7th's other plugins for more completion sources!

    -- To enable more of the features of rust-analyzer, such as inlay hints and more!
    use { 'simrat39/rust-tools.nvim' }

    -- Snippet engine
    use { 'hrsh7th/vim-vsnip' }

    -- Lualine
    use { 'nvim-lualine/lualine.nvim' }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- null-ls
    use { 'jose-elias-alvarez/null-ls.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            local null_ls = require('null-ls')

            null_ls.setup({
                sources = {
                    -- diagnostics
                    null_ls.builtins.diagnostics.actionlint,
                    null_ls.builtins.diagnostics.ansiblelint,
                    null_ls.builtins.diagnostics.flake8,
                    null_ls.builtins.diagnostics.hadolint,
                    null_ls.builtins.diagnostics.zsh,

                    -- formatters
                    null_ls.builtins.formatting.autopep8,
                    null_ls.builtins.formatting.shfmt,
                }
            })
        end
    }

    -- gitsigns
    use { 'lewis6991/gitsigns.nvim' }

    -- Markdown preview
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    -- undotree
    use { 'mbbill/undotree',
        config = function()
            vim.g.undotree_WindowLayout = 2
            vim.keymap.set('n', '<C-S-u>', '<cmd>UndotreeToggle<cr>', { noremap = true, desc = 'Open undotree' })
        end }

    -- fidget
    use { 'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup({})
        end }

    -- which-key
    use { 'folke/which-key.nvim',
        config = function()
            require('which-key').setup()
        end
    }
end)
