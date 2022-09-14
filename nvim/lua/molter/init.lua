require('molter.set')
require('molter.keymaps')
require('molter.vimplug')

-- Autocommands
local trim_whitespace = function()
    local ft = vim.bo.filetype

    if ft == 'diff' or ft == 'binary' then
        return
    end

    local view_save = vim.fn.winsaveview()
    vim.cmd([[
        keeppatterns %s/\s\+$//e
        keeppatterns %s/\n*\%$//
    ]])
    vim.fn.winrestview(view_save)
end

local molter = vim.api.nvim_create_augroup('MOLTER', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    group = molter,
    callback = trim_whitespace,
})
