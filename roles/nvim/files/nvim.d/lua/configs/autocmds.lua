if vim.env.TERM == 'xterm-kitty' then
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        callback = function ()
        local bufname = vim.api.nvim_buf_get_name(0)
        local filename = vim.fn.fnamemodify(bufname == '' and 'untitled' or bufname, ':~:h')

        io.write(string.format('\027]2;%s\007', filename))
    end,
    })
end
