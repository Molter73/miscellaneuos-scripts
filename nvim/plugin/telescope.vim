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
    },
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
})
END

:nnoremap <Leader>ff <cmd>Telescope find_files<cr>
:nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
:nnoremap <Leader>fb <cmd>Telescope buffers<cr>
:nnoremap <Leader>fs <cmd>Telescope grep_string<cr>
