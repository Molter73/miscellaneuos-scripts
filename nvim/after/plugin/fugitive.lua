-- Global configuration
vim.g.fugitive_dynamic_colors = 1

-- Keymaps for fugitive
vim.keymap.set('n', '<Leader>sdd', '<cmd>Gdiffsplit<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>sdt', '<cmd>G difftool<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>sc', '<cmd>G commit -v<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>sp', '<cmd>G push<CR>', { noremap = true })
