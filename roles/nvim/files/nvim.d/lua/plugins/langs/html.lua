return {
    {
        'mason-org/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'prettier',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                html = {},
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                html = { 'prettier' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'html',
            },
        },
    },
}
