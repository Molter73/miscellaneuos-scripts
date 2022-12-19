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

local builtins = require('telescope.builtin')

vim.keymap.set('n', '<Leader>ff', builtins.find_files, { noremap = true })
vim.keymap.set('n', '<Leader>fg', builtins.live_grep, { noremap = true })
vim.keymap.set('n', '<Leader>fb', builtins.buffers, { noremap = true })
vim.keymap.set('n', '<Leader>fs', builtins.grep_string, { noremap = true })
vim.keymap.set('n', '<Leader>fh', builtins.help_tags, { noremap = true })
vim.keymap.set('n', '<Leader>fd', builtins.diagnostics, { noremap = true })
