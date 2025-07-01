return {
    'nvim-mini/mini-git',
    main = "mini.git",
    version = '*',
    event = 'VeryLazy',
    opts = {
        command = {
            split = 'vertical',
        },
    },
    config = function(_, opts)
        local align_blame = function(au_data)
            if au_data.data.git_subcommand ~= 'blame' then return end

            local win_src = au_data.data.win_source

            vim.wo.wrap = false
            vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
            vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })

            vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
        end

        local au_opts = { pattern = 'MiniGitCommandSplit', callback = align_blame }

        vim.api.nvim_create_autocmd('User', au_opts)

        require('mini.git').setup(opts)
    end,
    keys = {
        {
            '<leader>gr',
            function()
                require('mini.git').show_at_cursor()
            end,
            desc = 'Git show_at_cursor',
            mode = { 'n', 'x' }
        },
    },
}
