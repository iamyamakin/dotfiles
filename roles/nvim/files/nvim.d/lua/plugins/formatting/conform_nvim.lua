return {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    event = 'BufWritePre',
    dependencies = { 'mason-org/mason.nvim' },
    lazy = true,
    opts = {
        default_format_opts = {
            async = false,
            lsp_format = 'fallback',
            quiet = false,
            timeout_ms = 3000,
        },
        formatters_by_ft = {
            ['_'] = { 'trim_whitespace', 'trim_newlines' },
        },
        formatters = {
            injected = { options = { ignore_errors = true } },
        },
    },
    init = function()
        GlobalUtils.on_very_lazy(function()
            GlobalUtils.format.register({
                name = 'conform.nvim',
                priority = 100,
                primary = true,
                format = function(buf)
                    require('conform').format({ bufnr = buf })
                end,
                sources = function(buf)
                    local ret = require('conform').list_formatters(buf)

                    return vim.tbl_map(function(v)
                        return v.name
                    end, ret)
                end,
            })
        end)
    end,
    keys = {
        {
            '<leader>cF',
            function()
                require('conform').format({ formatters = { 'injected' }, timeout_ms = 3000 })
            end,
            mode = { 'n', 'v' },
            desc = 'Format Injected Langs',
        },
    },
}
