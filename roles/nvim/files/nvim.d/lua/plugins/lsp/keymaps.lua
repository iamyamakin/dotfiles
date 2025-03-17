local _keys = nil

local function get()
    if _keys then
        return _keys
    end
    _keys =  {
        { '<leader>cl', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
        { 'gd', vim.lsp.buf.definition, desc = 'Goto Definition', has = 'definition' },
        { 'gr', vim.lsp.buf.references, desc = 'References', nowait = true },
        { 'gI', vim.lsp.buf.implementation, desc = 'Goto Implementation' },
        { 'gy', vim.lsp.buf.type_definition, desc = 'Goto T[y]pe Definition' },
        { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
        { 'K', function() return vim.lsp.buf.hover() end, desc = 'Hover' },
        { 'gK', function() return vim.lsp.buf.signature_help() end, desc = 'Signature Help', has = 'signatureHelp' },
        {
            '<c-k>',
            function() return vim.lsp.buf.signature_help() end,
            desc = 'Signature Help',
            mode = 'i',
            has = 'signatureHelp'
        },
        { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' },
        { '<leader>cc', vim.lsp.codelens.run, desc = 'Run Codelens', mode = { 'n', 'v' }, has = 'codeLens' },
        {
            '<leader>cC',
            vim.lsp.codelens.refresh,
            desc = 'Refresh & Display Codelens',
            mode = { 'n' },
            has = 'codeLens'
        },
        { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename', has = 'rename' },
        {
            '<leader>cR',
            function() Snacks.rename.rename_file() end,
            desc = 'Rename File',
            mode = { 'n' },
            has = { 'workspace/didRenameFiles', 'workspace/willRenameFiles' }
        },
        { '<leader>cA', GlobalUtils.lsp.action.source, desc = 'Source Action', has = 'codeAction' },
    }

    return _keys
end

local function has(buffer, method)
    if type(method) == 'table' then
        for _, m in ipairs(method) do
            if has(buffer, m) then
                return true
            end
        end

        return false
    end
    method = method:find('/') and method or 'textDocument/' .. method

    local clients = GlobalUtils.lsp.get_clients({ bufnr = buffer })

    for _, client in ipairs(clients) do
        if client.supports_method(method) then
            return true
        end
    end

    return false
end

local function resolve(buffer)
    local lazy_nvim_keys = require('lazy.core.handler.keys')

    if not lazy_nvim_keys.resolve then
        return {}
    end

    local spec = vim.tbl_extend('force', {}, get())
    local opts = GlobalUtils.opts('nvim-lspconfig')
    local clients = GlobalUtils.lsp.get_clients({ bufnr = buffer })

    for _, client in ipairs(clients) do
        local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}

        vim.list_extend(spec, maps)
    end

    return lazy_nvim_keys.resolve(spec)
end

local function on_attach(_, buffer)
    local lazy_nvim_keys = require('lazy.core.handler.keys')
    local keymaps = resolve(buffer)

    for _, keys in pairs(keymaps) do
        local has_buffer = not keys.has or has(buffer, keys.has)
        local cond = not (keys.cond == false or ((type(keys.cond) == 'function') and not keys.cond()))

        if has_buffer and cond then
            local opts = lazy_nvim_keys.opts(keys)

            opts.cond = nil
            opts.has = nil
            opts.silent = opts.silent ~= false
            opts.buffer = buffer
            vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
        end
    end
end

return {
    get = get,
    on_attach = on_attach,
}
