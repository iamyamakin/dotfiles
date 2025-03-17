return {
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                taplo = {},
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                toml = { 'taplo' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'toml',
            },
        },
    },
}
