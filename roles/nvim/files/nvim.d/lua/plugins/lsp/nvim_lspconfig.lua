return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
    },
    opts = {
        diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = {
                spacing = 4,
                source = 'if_many',
                prefix = function(diagnostic)
                    local icons = GlobalUtils.icons.diagnostics

                    for d, icon in pairs(icons) do
                        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                            return icon
                        end
                    end
                end,
            },
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = GlobalUtils.icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN] = GlobalUtils.icons.diagnostics.Warn,
                    [vim.diagnostic.severity.HINT] = GlobalUtils.icons.diagnostics.Hint,
                    [vim.diagnostic.severity.INFO] = GlobalUtils.icons.diagnostics.Info,
                },
            },
        },
        inlay_hints = {
            enabled = true,
            exclude = { 'vue' }, -- filetypes for which you don't want to enable inlay hints
        },
        codelens = {
            enabled = false,
        },
        capabilities = {
            workspace = {
                fileOperations = {
                    didRename = true,
                    willRename = true,
                },
            },
        },
        format = {
            formatting_options = nil,
            timeout_ms = nil,
        },
        setup = {
            ['*'] = function(_, _) end,
        },
    },
    config = function(_, opts)
        local previous_node_client = { id = nil, length = nil }

        GlobalUtils.format.register(GlobalUtils.lsp.formatter())
        GlobalUtils.lsp.on_attach(function(client, buffer)
            if (client.name == 'denols' or client.name == 'vtsls') then
                if previous_node_client.id == nil then
                    previous_node_client.id = client.id
                    previous_node_client.length = #client.root_dir
                else
                    if previous_node_client.length < #client.root_dir then
                        vim.lsp.stop_client(previous_node_client.id, true)
                    elseif previous_node_client.length > #client.root_dir then
                        vim.lsp.stop_client(client.id, true)
                    else
                        if client.name == 'denols' then
                            vim.lsp.stop_client(client.id, true)
                        else
                            vim.lsp.stop_client(previous_node_client.id, true)
                        end
                    end
                    previous_node_client = { id = nil, length = nil }
                end
            end
            require('plugins.lsp.keymaps').on_attach(client, buffer)
        end)
        GlobalUtils.lsp.setup()
        GlobalUtils.lsp.on_dynamic_capability(require('plugins.lsp.keymaps').on_attach)

        if opts.inlay_hints.enabled then
            GlobalUtils.lsp.on_supports_method('textDocument/inlayHint', function(_, buffer)
                if
                    vim.api.nvim_buf_is_valid(buffer)
                    and vim.bo[buffer].buftype == ''
                    and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
                then
                    vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                end
            end)
        end

        if opts.codelens.enabled and vim.lsp.codelens then
            GlobalUtils.lsp.on_supports_method('textDocument/codeLens', function(_, buffer)
                vim.lsp.codelens.refresh()
                vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
                    buffer = buffer,
                    callback = vim.lsp.codelens.refresh,
                })
            end)
        end

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        local capabilities = vim.tbl_deep_extend(
            'force',
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require('blink.cmp').get_lsp_capabilities() or {},
            opts.capabilities or {}
        )
        local servers = opts.servers

        local function setup(server)
            local server_opts = vim.tbl_deep_extend('force', {
                capabilities = vim.deepcopy(capabilities),
            }, servers[server] or {})

            if server_opts.enabled == false then
                return
            end

            if opts.setup[server] then
                if opts.setup[server](server, server_opts) then
                    return
                end
            elseif opts.setup['*'] and opts.setup['*'](server, server_opts) then
                return
            end
            require('lspconfig')[server].setup(server_opts)
        end

        local all_servers = vim.tbl_keys(require('mason-lspconfig').get_mappings().lspconfig_to_package)

        local ensure_installed = {}

        for server, server_opts in pairs(servers) do
            if server_opts then
                server_opts = server_opts == true and {} or server_opts
                if server_opts.enabled ~= false then
                    if server_opts.mason == false or not vim.tbl_contains(all_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end
        end
        require('mason-lspconfig').setup({
            automatic_installation = false,
            ensure_installed = vim.tbl_deep_extend(
                'force',
                ensure_installed,
                GlobalUtils.opts('mason-lspconfig.nvim').ensure_installed or {}
            ),
            handlers = { setup },
        })
    end,
}
