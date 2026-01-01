return {
    {
        'mason-org/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'goimports',
                'gofumpt',
                'golangci-lint',
                'gomodifytags',
                'impl',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                gopls = {
                    settings = {
                        gopls = {
                            analyses = {
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                            },
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            completeUnimported = true,
                            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
                            gofumpt = true,
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            semanticTokens = true,
                            staticcheck = true,
                            usePlaceholders = true,
                        },
                    },
                    keys = {
                        {
                            '<leader>cgt',
                            function()
                                vim.ui.input({ prompt = 'Add tags: ' }, function(input)
                                    if input then
                                        vim.cmd('silent !gomodifytags -add-tags ' .. input .. ' -file %')
                                        vim.cmd('edit')
                                    end
                                end)
                            end,
                            desc = 'Add struct tags',
                            ft = 'go',
                        },
                        {
                            '<leader>cgT',
                            function()
                                vim.ui.input({ prompt = 'Remove tags: ' }, function(input)
                                    if input then
                                        vim.cmd('silent !gomodifytags -remove-tags ' .. input .. ' -file %')
                                        vim.cmd('edit')
                                    end
                                end)
                            end,
                            desc = 'Remove struct tags',
                            ft = 'go',
                        },
                        {
                            '<leader>cgi',
                            function()
                                vim.ui.input({ prompt = 'Interface to implement: ' }, function(iface)
                                    if iface then
                                        vim.ui.input({ prompt = 'Receiver name: ' }, function(recv)
                                            if recv then
                                                local cmd = string.format('impl "%s" %s', recv, iface)
                                                vim.fn.execute('r!' .. cmd)
                                            end
                                        end)
                                    end
                                end)
                            end,
                            desc = 'Implement interface',
                            ft = 'go',
                        },
                    },
                },
            },
            setup = {
                gopls = function()
                    GlobalUtils.lsp.on_attach(function(client, _)
                        if not client.server_capabilities.semanticTokensProvider then
                            local semantic = client.config.capabilities.textDocument.semanticTokens

                            client.server_capabilities.semanticTokensProvider = {
                                full = true,
                                legend = {
                                    tokenTypes = semantic.tokenTypes,
                                    tokenModifiers = semantic.tokenModifiers,
                                },
                                range = true,
                            }
                        end
                    end, 'gopls')
                end,
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        optional = true,
        opts = {
            linters_by_ft = {
                go = { 'golangcilint' },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                go = { 'goimports', 'gofumpt' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'go',
                'gomod',
                'gosum',
                'gowork',
            },
        },
    },
}
