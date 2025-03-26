return {
    {
        'williamboman/mason.nvim',
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
                vuels = {},
                volar = {
                    init_options = {
                        vue = {
                            hybridMode = true,
                        },
                    },
                },
                vtsls = {},
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
