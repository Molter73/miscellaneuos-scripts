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
            "^.git/"
        },
    },
})

vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.keymap.set('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.keymap.set('n', '<Leader>fs', '<cmd>Telescope grep_string<cr>', { noremap = true })
vim.keymap.set('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true })
