local M = {}

local execute_jq = function(args)
    if vim.bo.filetype ~= 'json' then
        return
    end

    local replace_data = function(_, data)
        if data and data[1] ~= '' then
            vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
        end
    end

    local print_error = function(_, data)
        if data and data[1] ~= '' then
            for _, value in pairs(data) do
                print(value)
            end
        end
    end

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local json = ''
    for _, line in ipairs(lines) do
        json = json .. line
    end

    vim.fn.jobstart({ 'jq', args, json },
        { stdout_buffered = true, stderr_buffered = true, on_stdout = replace_data, on_stderr = print_error })
end

M.format_json = function()
    execute_jq('-n')
end

M.minify_json = function()
    execute_jq('-cn')
end

return M
