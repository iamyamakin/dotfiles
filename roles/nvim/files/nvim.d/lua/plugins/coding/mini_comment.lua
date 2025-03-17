return {
    {
        'echasnovski/mini.comment',
        event = 'VeryLazy',
        opts = {
            options = {
                custom_commentstring = function()
                    local ts_context_commentstring = require('ts_context_commentstring.internal')

                    return ts_context_commentstring.calculate_commentstring() or vim.bo.commentstring
                end,
            },
        },
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },
}
