return {
    {
        'mason-org/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'shellcheck',
                'shfmt',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                bashls = {},
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                bash = { 'shfmt' },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        optional = true,
        opts = {
            linters_by_ft = {
                bash = { 'bash' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'bash',
            },
        },
    },
}
