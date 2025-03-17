return {
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'hadolint',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                dockerls = {},
                docker_compose_language_service = {},
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        optional = true,
        opts = {
            linters_by_ft = {
                dockerfile = { 'hadolint' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'dockerfile',
            },
        },
    },
}
