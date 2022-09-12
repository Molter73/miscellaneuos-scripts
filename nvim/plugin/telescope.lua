local telescope = require('telescope')

telescope.setup({
    pickers = {
        find_files = {
            hidden = true
        },
    },
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",
            "--smart-case"
        },
        file_ignore_patterns = {
            "%.git/*"
        },
    },
})

vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fs', '<cmd>Telescope grep_string<cr>', { noremap = true })
