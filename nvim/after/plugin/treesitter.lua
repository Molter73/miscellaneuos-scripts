require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'cmake',
        'dockerfile',
        'go',
        'json',
        'lua',
        'make',
        'python',
        'regex',
        'rust',
        'toml',
    },

    highlight = {
        enable = true,
    },
})

require('treesitter-context').setup({
    max_lines = 10,
})
