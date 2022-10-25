require('molter.set')
require('molter.keymaps')
require('molter.vimplug')

vim.opt.runtimepath:append("~/go/src/github.com/tamton-aquib/duck.nvim")

-- Autocommands
local trim_whitespace = function()
    local ft = vim.bo.filetype

    if ft == 'diff' or ft == 'binary' then
        return
    end

    local view_save = vim.fn.winsaveview()
    vim.cmd([[
        keeppatterns %s/\s\+$//e
        keeppatterns %s/\n*\%$//e
    ]])
    vim.fn.winrestview(view_save)
end

local molter = vim.api.nvim_create_augroup('MOLTER', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    group = molter,
    callback = trim_whitespace,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    group = molter,
    callback = function()
        vim.keymap.set('n', '<Leader>md', '<CMD>MarkdownPreview<CR>', {
            noremap = true,
            buffer = 0,
        })
    end
})

local yank_highlight = vim.api.nvim_create_augroup('YankHighlist', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_highlight,
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
    end
})
