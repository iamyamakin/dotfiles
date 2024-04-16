local enabled_lsp_servers = require('config').enabled_lsp_servers

local function after_install()
    require('mason').setup()

    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = enabled_lsp_servers,
        handlers = {
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            denols = function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
                })
            end,
            tsserver = function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern('tsconfig.json', 'jsconfig.json'),
                })
            end,
        },
    })

    vim.g.lspTimeoutConfig = {
        stopTimeout = 1000 * 60 * 5,
        startTimeout = 1000 * 5,
        silent = false,
        filetypes = {
            ignore = {},
        },
    }
end

local function install(use)
    use({
        'williamboman/mason.nvim',
        run = ':MasonUpdate',
    })
    use('williamboman/mason-lspconfig.nvim')
    use('neovim/nvim-lspconfig')
    use({
        'hinell/lsp-timeout.nvim',
        requires = { 'neovim/nvim-lspconfig' }
    })

    vim.diagnostic.config({
        virtual_text = false,
        float = {
            source = true,
        },
    })
    for _, diag in ipairs({ 'Error', 'Warn', 'Info', 'Hint' }) do
        vim.fn.sign_define("DiagnosticSign" .. diag, {
            text = "",
            texthl = "DiagnosticSign" .. diag,
            linehl = "",
            numhl = "DiagnosticSign" .. diag,
        })
    end
end

local keys = {
    l = {
        name = 'lsp',
        E = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'jumps to the declaration of the symbol under the cursor' },
        F = {
            '<cmd>lua vim.lsp.buf.format({ timeout_ms = 5000 })<cr>',
            'formats a buffer using the attached (and optionally filtered) language server clients',
        },
        R = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'renames all references to the symbol under the cursor' },
        a = {
            '<cmd>lua vim.lsp.buf.code_action()<cr>',
            'selects a code action available at the current cursor position',
        },
        d = {
            name = 'diagnostic',
            d = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'show diagnostics in a floating window' },
            e = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'move to the previous diagnostic in the current buffer' },
            n = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'move to the next diagnostic' },
            t = {
                '<cmd>lua if vim.diagnostic.is_disabled() then vim.diagnostic.enable() else vim.diagnostic.disable() end<cr>',
                'toggle diagnostic',
            },
        },
        e = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'jumps to the definition of the symbol under the cursor' },
        f = { '<cmd>Format<cr>', 'format by formatter' },
        h = {
            '<cmd>lua vim.lsp.buf.hover()<cr>',
            'displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window',
        },
        i = {
            '<cmd>lua vim.lsp.buf.implementation()<cr>',
            'lists all the implementations for the symbol under the cursor in the quickfix window',
        },
        l = { '<cmd>lua vim.diagnostic.setloclist({ wrap = true })<cr>', 'set location list' },
        r = {
            '<cmd>lua vim.lsp.buf.references()<cr>',
            'lists all the references to the symbol under the cursor in the quickfix window',
        },
        s = {
            '<cmd>lua vim.lsp.buf.signature_help()<cr>',
            'displays signature information about the symbol under the cursor in a floating window',
        },
        t = {
            '<cmd>lua vim.lsp.buf.type_definition()<cr>',
            'jumps to the definition of the type of the symbol under the cursor',
        },
        w = {
            name = 'workspace actions...',
            a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', 'add the folder at path to the workspace folders' },
            l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', 'list folders in workspace' },
            r = {
                '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>',
                'remove the folder at path from the workspace folders',
            },
        },
    },
}

return {
    after_install = after_install,
    install = install,
    keys = keys,
}
