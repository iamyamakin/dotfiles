return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            always_show_bufferline = false,
            close_command = function(n) Snacks.bufdelete(n) end,
            get_element_icon = function(opts)
                return GlobalUtils.icons.ft[opts.filetype]
            end,
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(_, _, diag)
                local icons = GlobalUtils.icons.diagnostics
                local result = (diag.error and icons.Error .. diag.error .. ' ' or '')
                    .. (diag.warning and icons.Warn .. diag.warning or '')

                return vim.trim(result)
            end,
            offsets = {
                {
                    filetype = 'neo-tree',
                    text = 'Neo-tree',
                    highlight = 'Directory',
                    text_align = 'left',
                },
            },
            right_mouse_command = function(n) Snacks.bufdelete(n) end,
        },
    },
    keys = {
        { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
        { '<leader>bo', function() Snacks.bufdelete.other() end, desc = 'Delete Other Buffers' },
        { '<leader>bD', '<cmd>:bd<cr>', desc = 'Delete Buffer and Window' },
        { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle Pin' },
        { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = 'Delete Non-Pinned Buffers' },
        { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Delete Buffers to the Right' },
        { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Delete Buffers to the Left' },
        { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
        { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
        { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
        { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
        { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
        { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    config = function(_, opts)
        require('bufferline').setup(opts)
        vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
            callback = function()
                vim.schedule(function()
                    -- luacheck: globals nvim_bufferline
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end,
}
