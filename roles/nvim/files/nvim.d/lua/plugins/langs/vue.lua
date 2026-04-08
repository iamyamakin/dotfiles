return {
    {
        'mason-org/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'biome',
                'prettier',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                vue_ls = {
                    root_dir = function(fname)
                        return require('lspconfig.util').root_pattern(
                            'vue.config.js',
                            'vue.config.ts',
                            'nuxt.config.js',
                            'nuxt.config.ts'
                        )(fname)
                    end,
                    init_options = {
                        vue = {
                            hybridMode = true,
                        },
                    },
                },
                vtsls = {
                    filetypes = { 'vue' },
                },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                vue = { 'biome', 'prettier' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'vue',
            },
        },
    },
}
