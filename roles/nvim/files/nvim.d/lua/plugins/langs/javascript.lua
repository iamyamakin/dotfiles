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
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                javascript = { 'biome', 'prettier' },
                javascriptreact = { 'biome', 'prettier' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'javascript',
            },
        },
    },
}
