return {
    'mfussenegger/nvim-ansible',
    {
        'mason-org/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'ansible-lint',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                ansiblels = {},
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                ['yaml.ansible'] = { 'yamlfmt' },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        optional = true,
        opts = {
            linters_by_ft = {
                ansible = { 'ansible_lint' },
            },
        },
    },
}
