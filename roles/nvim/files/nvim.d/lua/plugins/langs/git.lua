return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
            },
        },
    },
}
