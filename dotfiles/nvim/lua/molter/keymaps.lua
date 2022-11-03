-- Global Keymaps
vim.keymap.set('n', '<Leader>ej', '<cmd>Ex<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ev', '<cmd>Vex<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>eh', '<cmd>Sex<CR>', { noremap = true })

-- Navigate quickfixes
vim.keymap.set('n', ']q', '<cmd>cn<CR>', { noremap = true })
vim.keymap.set('n', '[q', '<cmd>cp<CR>', { noremap = true })
