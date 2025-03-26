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
                graphql = {},
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                graphql = { 'biome', 'prettier' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'graphql',
            },
        },
    },
}
