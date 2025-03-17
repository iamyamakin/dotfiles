local action = setmetatable({}, {
    __index = function(_, action)
        return function()
            vim.lsp.buf.code_action({
                apply = true,
                context = {
                    diagnostics = {},
                    only = { action },
                },
            })
        end
    end,
})
local supports_method = {}

local function check_methods(client, buffer)
    if not vim.api.nvim_buf_is_valid(buffer) or not vim.bo[buffer].buflisted or vim.bo[buffer].buftype == 'nofile' then
        return
    end
    for method, clients in pairs(supports_method) do
        clients[client] = clients[client] or {}
        if not clients[client][buffer] then
            if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
                clients[client][buffer] = true
                vim.api.nvim_exec_autocmds('User', {
                    pattern = 'LspSupportsMethod',
                    data = { client_id = client.id, buffer = buffer, method = method },
                })
            end
        end
    end
end

local function execute(opts)
    local params = {
        command = opts.command,
        arguments = opts.arguments,
    }
    if opts.open then
        require('trouble').open({
            mode = 'lsp_command',
            params = params,
        })
    else
        vim.lsp.buf_request(0, 'workspace/executeCommand', params, opts.handler)
    end
end

local function get_clients(opts)
    local result = vim.lsp.get_clients(opts)

    if opts and opts.filter then
        result = vim.tbl_filter(opts.filter, result)
    end

    return result
end

local function format(opts)
    local lspconfig_format = GlobalUtils.opts('nvim-lspconfig').format or {}
    local conform_format = GlobalUtils.opts('conform.nvim').format or {}

    opts = opts or {}
    opts = vim.tbl_deep_extend('force', {}, opts, lspconfig_format, conform_format)
    opts.formatters = {}
    require('conform').format(opts)
end

local function formatter(opts)
    opts = opts or {}

    local filter = opts.filter or {}

    filter = type(filter) == 'string' and { name = filter } or filter

    local result = {
        name = 'LSP',
        primary = true,
        priority = 1,
        format = function(buf)
            format(GlobalUtils.merge({}, filter, { bufnr = buf }))
        end,
        sources = function(buf)
            local clients = get_clients(GlobalUtils.merge({}, filter, { bufnr = buf }))
            local result = vim.tbl_filter(function(client)
                return client.supports_method('textDocument/formatting')
                or client.supports_method('textDocument/rangeFormatting')
            end, clients)

            return vim.tbl_map(function(client) return client.name end, result)
        end,
    }

    return GlobalUtils.merge(result, opts)
end

local function get_config(server)
    return rawget(require('lspconfig.configs'), server)
end

local function disable(server, condition)
    local util = require('lspconfig.util')
    local config = get_config(server)

    config.document_config.on_new_config = util.add_hook_before(
        config.document_config.on_new_config,
        function(new_config, new_root_dir)
            if condition(new_root_dir, new_config) then
                new_config.enabled = false
            end
    end)
end

local function is_enabled(server)
    local config = get_config(server)

    return config and config.enabled ~= false
end

local function on_attach(fn, name)
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if client and (not name or client.name == name) then
                return fn(client, buffer)
            end
        end,
    })
end

local function on_dynamic_capability(fn, opts)
    return vim.api.nvim_create_autocmd('User', {
        pattern = 'LspDynamicCapability',
        group = opts and opts.group or nil,
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if client then
                return fn(client, args.data.buffer)
            end
        end,
    })
end

local function on_supports_method(method, fn)
    supports_method[method] = supports_method[method] or setmetatable({}, { __mode = 'k' })

    return vim.api.nvim_create_autocmd('User', {
        pattern = 'LspSupportsMethod',
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local buffer = args.data.buffer

            if client and method == args.data.method then
                return fn(client, buffer)
            end
        end,
    })
end

local function setup()
    local register_capability = vim.lsp.handlers['client/registerCapability']

    vim.lsp.handlers['client/registerCapability'] = function(err, res, context)
        local result = register_capability(err, res, context)
        local client = vim.lsp.get_client_by_id(context.client_id)

        if client then
            for buffer in pairs(client.attached_buffers) do
                vim.api.nvim_exec_autocmds('User', {
                    pattern = 'LspDynamicCapability',
                    data = { client_id = client.id, buffer = buffer },
                })
            end
        end

        return result
    end
    on_attach(check_methods)
    on_dynamic_capability(check_methods)
end

return {
    action = action,
    disable = disable,
    format = format,
    formatter = formatter,
    execute = execute,
    get_clients = get_clients,
    get_config = get_config,
    is_enabled = is_enabled,
    on_attach = on_attach,
    on_dynamic_capability = on_dynamic_capability,
    on_supports_method = on_supports_method,
    setup = setup,
}

