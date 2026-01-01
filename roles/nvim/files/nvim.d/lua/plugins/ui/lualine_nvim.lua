return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            vim.o.statusline = ' '
        else
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        local lualine_require = require('lualine_require')

        lualine_require.require = require

        local icons = GlobalUtils.icons

        vim.o.laststatus = vim.g.lualine_laststatus

        local opts = {
            options = {
                theme = 'auto',
                globalstatus = vim.o.laststatus == 3,
                disabled_filetypes = { statusline = { 'snacks_dashboard' } },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },

                lualine_c = {
                    GlobalUtils.lualine.root_dir(),
                    {
                        'diagnostics',
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                    },
                    { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                    { GlobalUtils.lualine.pretty_path() },
                },
                lualine_x = {
                    Snacks.profiler.status(),
                    {
                        function() return require('noice').api.status.command.get() end,
                        cond = function()
                            return package.loaded['noice'] and require('noice').api.status.command.has()
                        end,
                        color = function() return { fg = GlobalUtils.color('Statement') } end,
                    },
                    {
                        function() return require('noice').api.status.mode.get() end,
                        cond = function()
                            return package.loaded['noice'] and require('noice').api.status.mode.has()
                        end,
                        color = function() return { fg = GlobalUtils.color('Constant') } end,
                    },
                    {
                        function() return '  ' .. require('dap').status() end,
                        cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
                        color = function() return { fg = GlobalUtils.color('Debug') } end,
                    },
                    {
                        require('lazy.status').updates,
                        cond = require('lazy.status').has_updates,
                        color = function() return { fg = GlobalUtils.color('Special') } end,
                    },
                    {
                        'lsp_status',
                        icon = '',
                        symbols = {
                            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                            done = '✓',
                            separator = ' ',
                        },
                        ignore_lsp = {},
                        show_name = true,
                    },
                    {
                        'diff',
                        source = function()
                            local summary = vim.b.minidiff_summary

                            return summary
                                and {
                                    added = summary.add,
                                    modified = summary.change,
                                    removed = summary.delete,
                                }
                        end,
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                    },
                },
                lualine_y = {
                    { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
                    { 'location', padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return ' ' .. os.date('%R')
                    end,
                },
            },
            extensions = { 'fzf', 'lazy', 'neo-tree', 'trouble' },
        }

        return opts
    end,
}
