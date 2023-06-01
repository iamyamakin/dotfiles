local enabled_lsp_servers = require('config').enabled_lsp_servers

local function after_install()
    require('mason').setup()
    require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = enabled_lsp_servers,
    })
    require('lsp-status').config({
        current_function = false,
        indicator_errors = 'E:',
        indicator_warnings = 'W:',
        indicator_info = 'I:',
        indicator_hint = 'H:',
        indicator_ok = 'Ok',
        show_filename = false,
    })
end

local function install(use)
    use({
        'williamboman/mason.nvim',
        run = ':MasonUpdate'
    })
    use('williamboman/mason-lspconfig.nvim')
    use('neovim/nvim-lspconfig')
    use('nvim-lua/lsp-status.nvim')
end

local keys = {
  l = {
    name = 'lsp',
    E = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'jumps to the declaration of the symbol under the cursor' },
    R = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'renames all references to the symbol under the cursor' },
    a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'selects a code action available at the current cursor position' },
    d = {
      name = 'diagnostic',
      d = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'show diagnostics in a floating window' },
      e = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'move to the previous diagnostic in the current buffer' },
      n = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'move to the next diagnostic' },
    },
    e = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'jumps to the definition of the symbol under the cursor' },
    f = { '<cmd>lua vim.lsp.buf.format({ timeout_ms = 5000 })<cr>', 'formats a buffer using the attached (and optionally filtered) language server clients' },
    h = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window' },
    i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'lists all the implementations for the symbol under the cursor in the quickfix window' },
    l = { '<cmd>lua vim.diagnostic.setloclist()<cr>', 'set location list' },
    r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'lists all the references to the symbol under the cursor in the quickfix window' },
    s = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'displays signature information about the symbol under the cursor in a floating window' },
    t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'jumps to the definition of the type of the symbol under the cursor' },
    w = {
      name = 'workspace actions...',
      a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', 'add the folder at path to the workspace folders' },
      l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', 'list folders in workspace' },
      r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', 'remove the folder at path from the workspace folders' },
    },
  },
}

return {
    after_install = after_install,
    install = install,
    keys = keys,
}

