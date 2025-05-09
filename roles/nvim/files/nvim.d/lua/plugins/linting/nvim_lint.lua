return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
        linters_by_ft = {},
    },
    config = function(_, opts)
        local function debounce(ms, fn)
            local timer = vim.uv.new_timer()

            return function(...)
                local argv = { ... }

                if timer ~= nil then
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)(unpack(argv))
                    end)
                end
            end
        end

        local lint = require('lint');

        lint.linters_by_ft = opts.linters_by_ft
        vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
            group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
            callback = debounce(120, function()
                lint.try_lint()
            end),
        })
    end,
}
