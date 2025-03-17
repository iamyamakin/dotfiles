return {
    {
        'folke/which-key.nvim',
        opts = {
            spec = {
                { '<bs>', desc = 'Decrement Selection', mode = 'x' },
                { '<c-space>', desc = 'Increment Selection', mode = { 'x', 'n' } },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
        build = ':TSUpdate',
        cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
        lazy = vim.fn.argc(-1) == 0,
        init = function(plugin)
            require('lazy.core.loader').add_to_rtp(plugin)
            require('nvim-treesitter.query_predicates')
        end,
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                'c',
                'diff',
                'editorconfig',
                'jq',
                'query',
                'regex',
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']c'] = '@class.outer',
                        [']a'] = '@parameter.inner',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']C'] = '@class.outer',
                        [']A'] = '@parameter.inner',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[c'] = '@class.outer',
                        ['[a'] = '@parameter.inner',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[C'] = '@class.outer',
                        ['[A'] = '@parameter.inner' ,
                    },
                },
            },
        },
        opts_extend = { 'ensure_installed' },
        keys = {
            { '<c-space>', desc = 'Increment Selection' },
            { '<bs>', desc = 'Decrement Selection', mode = 'x' },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                opts.ensure_installed = GlobalUtils.dedup(opts.ensure_installed)
            end
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}
