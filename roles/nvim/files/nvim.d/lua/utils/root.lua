local cache = {}

local function realpath(path)
    if path == '' or path == nil then
        return nil
    end
    path = vim.uv.fs_realpath(path) or path

    return GlobalUtils.norm(path)
end

local function bufpath(buf)
    return realpath(vim.api.nvim_buf_get_name(assert(buf)))
end

local function cwd()
    return realpath(vim.uv.cwd()) or ''
end

local detectors = {
    cwd = function()
        return { vim.uv.cwd() }
    end,
    lsp = function(buf)
        local buf_path = bufpath(buf)

        if not buf_path then
            return {}
        end

        local roots = {}
        local clients = GlobalUtils.lsp.get_clients({ bufnr = buf })

        clients = vim.tbl_filter(function(client)
            return not vim.tbl_contains(vim.g.root_lsp_ignore or {}, client.name)
        end, clients)
        for _, client in pairs(clients) do
            local workspace = client.config.workspace_folders

            for _, ws in pairs(workspace or {}) do
                roots[#roots + 1] = vim.uri_to_fname(ws.uri)
            end
            if client.root_dir then
                roots[#roots + 1] = client.root_dir
            end
        end

        return vim.tbl_filter(function(path)
            path = GlobalUtils.norm(path)

            return path and buf_path:find(path, 1, true) == 1
        end, roots)
    end,
    pattern = function(buf, patterns)
        patterns = type(patterns) == 'string' and { patterns } or patterns

        local path = bufpath(buf) or vim.uv.cwd()
        local pattern = vim.fs.find(function(name)
            for _, p in ipairs(patterns) do
                if name == p then
                    return true
                end
                if p:sub(1, 1) == '*' and name:find(vim.pesc(p:sub(2)) .. '$') then
                    return true
                end
            end

            return false
        end, { path = path, upward = true })[1]

        return pattern and { vim.fs.dirname(pattern) } or {}
    end,
}

local function resolve(spec)
    if detectors[spec] then
        return detectors[spec]
    elseif type(spec) == 'function' then
        return spec
    end

    return function(buf)
        return detectors.pattern(buf, spec)
    end
end

local function detect(opts)
    opts = opts or {}
    opts.spec = opts.spec or type(vim.g.root_spec) == 'table' and vim.g.root_spec or { 'lsp', { '.git', 'lua' }, 'cwd' }
    opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

    local result = {}

    for _, spec in ipairs(opts.spec) do
        local paths = resolve(spec)(opts.buf)

        paths = paths or {}
        paths = type(paths) == 'table' and paths or { paths }

        local roots = {}

        for _, p in ipairs(paths) do
            local pp = realpath(p)
            if pp and not vim.tbl_contains(roots, pp) then
                roots[#roots + 1] = pp
            end
        end
        table.sort(roots, function(a, b) return #a > #b end)
        if #roots > 0 then
            result[#result + 1] = { spec = spec, paths = roots }
            if opts.all == false then
                break
            end
        end
    end

    return result
end

local function get(opts)
    opts = opts or {}

    local buf = opts.buf or vim.api.nvim_get_current_buf()
    local result = cache[buf]

    if not result then
        local roots = detect({ all = false, buf = buf })

        result = roots[1] and roots[1].paths[1] or vim.uv.cwd()
        cache[buf] = result
    end

    return result
end

local function git()
  local root = get()
  local git_root = vim.fs.find('.git', { path = root, upward = true })[1]
  local result = git_root and vim.fn.fnamemodify(git_root, ':h') or root

  return result
end

return setmetatable({
    cwd = cwd,
    get = get,
    git = git,
}, {
  __call = function(m, ...)
    return m.get(...)
  end,
})
