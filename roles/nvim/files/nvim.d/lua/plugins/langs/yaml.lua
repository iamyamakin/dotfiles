return {
    {
        'b0o/schemastore.nvim',
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'prettier',
                'yamlfmt',
                'yamllint',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                yamlls = {
                    on_new_config = function(new_config)
                        new_config.settings.yaml.schemas = vim.tbl_deep_extend(
                            'force',
                            new_config.settings.yaml.schemas or {},
                            require('schemastore').yaml.schemas()
                        )
                    end,
                    settings = {
                        yaml = {
                            capabilities = {
                                textDocument = {
                                    foldingRange = {
                                        lineFoldingOnly = true,
                                    },
                                },
                            },
                            schemaStore = {
                                enable = false,
                                url = '',
                            },
                            validate = true,
                        },
                    },
                },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                yaml = { 'prettier' },
                ['yaml.ansible'] = { 'yamlfmt' },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        optional = true,
        opts = {
            linters_by_ft = {
                yaml = { 'yamllint' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'yaml',
            },
        },
    },
}
