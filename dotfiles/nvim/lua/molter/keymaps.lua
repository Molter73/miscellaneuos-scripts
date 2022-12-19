-- Global Keymaps
-- netrw
vim.keymap.set('n', '<Leader>ej', '<cmd>Ex<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ev', '<cmd>Vex<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>eh', '<cmd>Sex<CR>', { noremap = true })

-- Page up and down with auto-center
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })

-- Navigate quickfixes
vim.keymap.set('n', ']q', '<cmd>cn<CR>', { noremap = true })
vim.keymap.set('n', '[q', '<cmd>cp<CR>', { noremap = true })

-- pop-up diagnostics
vim.keymap.set('n', '<Leader>q', vim.diagnostic.open_float, { noremap = true })
