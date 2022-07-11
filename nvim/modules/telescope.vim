lua << END
local telescope = require('telescope')

telescope.setup({
    pickers = {
        find_files = {
            hidden = true
        },
        live_grep = {
            hidden = true
        }
    }
})
END

:nnoremap <Leader>ff <cmd>Telescope find_files<cr>
:nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
:nnoremap <Leader>fb <cmd>Telescope buffers<cr>
