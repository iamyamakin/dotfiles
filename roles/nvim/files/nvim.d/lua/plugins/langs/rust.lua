return {
    {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    {
        'mason-org/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'bacon',
                'codelldb',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                bacon_ls = { enabled = true },
                rust_analyzer = { enabled = false },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                rust = { 'rustfmt' },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = {
            ensure_installed = {
                'ron',
                'rust',
            },
        },
    },
    {
        'mrcjkb/rustaceanvim',
        dependencies = 'mason.nvim',
        ft = { 'rust' },
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set(
                        'n',
                        '<leader>cR',
                        function() vim.cmd.RustLsp('codeAction') end,
                        { desc = 'Code Action', buffer = bufnr }
                    )
                    vim.keymap.set(
                        'n',
                        '<leader>dr',
                        function() vim.cmd.RustLsp('debuggables') end,
                        { desc = 'Rust Debuggables', buffer = bufnr }
                    )
                end,
                default_settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true,
                            buildScripts = {
                                enable = true,
                            },
                            loadOutDirsFromCheck = true,
                        },
                        checkOnSave = true,
                        diagnostics = {
                            enable = true,
                        },
                        procMacro = {
                            enable = true,
                            ignored = {
                                ['async-recursion'] = { 'async_recursion' },
                                ['async-trait'] = { 'async_trait' },
                                ['napi-derive'] = { 'napi' },
                            },
                        },
                        files = {
                            excludeDirs = {
                                '.direnv',
                                '.git',
                                '.github',
                                '.gitlab',
                                '.venv',
                                'bin',
                                'node_modules',
                                'target',
                                'venv',
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local package_path = require('mason-registry').get_package('codelldb'):get_install_path()
            local codelldb = package_path .. '/extension/adapter/codelldb'
            local library_path = package_path .. '/extension/lldb/lib/liblldb.dylib'
            local uname = io.popen('uname'):read('*l')

            if uname == 'Linux' then library_path = package_path .. '/extension/lldb/lib/liblldb.so' end
            opts.dap = {
                adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb, library_path),
            }
            vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
            if vim.fn.executable('rust-analyzer') == 0 then
                GlobalUtils.error(
                    '**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/',
                    { title = 'rustaceanvim' }
                )
            end
        end,
    },
}
