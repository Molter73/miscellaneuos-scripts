local duck = function()
    require('duck').hatch()
end

local cat = function()
    require('duck').hatch('🐈')
end

local chick = function()
    require('duck').hatch('🐤')
end

local cook = function()
    require('duck').cook()
end

local cook_all = function()
    while next(require('duck').ducks_list) do
        cook()
    end
end

vim.keymap.set('n', '<Leader>hd', duck, { noremap = true })
vim.keymap.set('n', '<Leader>hh', chick, { noremap = true })
vim.keymap.set('n', '<Leader>hm', cat, { noremap = true })
vim.keymap.set('n', '<Leader>hc', cook, { noremap = true })
vim.keymap.set('n', '<Leader>ha', cook_all, { noremap = true })
