local function color(group, prop)
    prop = prop or 'fg'
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })

    return hl[prop] and string.format('#%06x', hl[prop])
end

local function dedup(list)
    local ret = {}
    local seen = {}

    for _, v in ipairs(list) do
        if not seen[v] then
            table.insert(ret, v)
            seen[v] = true
        end
    end
    return ret
end

local function get_plugin(name)
    return require('lazy.core.config').spec.plugins[name]
end

local function is_loaded(name)
    return require('lazy.core.config').plugins[name] and require('lazy.core.config').plugins[name]._.loaded
end

local cache = {}

local function memoize(fn)
    return function(...)
        local key = vim.inspect({ ... })

        cache[fn] = cache[fn] or {}
        if cache[fn][key] == nil then
            cache[fn][key] = fn(...)
        end

        return cache[fn][key]
    end
end

local function on_very_lazy(fn)
    vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
            fn()
        end,
    })
end

local function opts(name)
    local plugin = get_plugin(name)

    if not plugin then
        return {}
    end

    return require('lazy.core.plugin').values(plugin, 'opts', false)
end

local function safe_keymap_set(mode, lhs, rhs, new_opts)
    local keys = require('lazy.core.handler').handlers.keys
    local modes = type(mode) == 'string' and { mode } or mode

    modes = vim.tbl_filter(function(m)
        return not (keys.have and keys:have(lhs, m))
    end, modes)

    if #modes > 0 then
        new_opts = new_opts or {}
        new_opts.silent = new_opts.silent ~= false
        if new_opts.remap and not vim.g.vscode then
            new_opts.remap = nil
        end
        vim.keymap.set(modes, lhs, rhs, new_opts)
    end
end

return setmetatable({
    color = color,
    dedup = dedup,
    get_plugin = get_plugin,
    is_loaded = is_loaded,
    memoize = memoize,
    on_very_lazy = on_very_lazy,
    opts = opts,
    safe_keymap_set = safe_keymap_set,
}, {
    __index = function(t, k)
        if require('lazy.core.util')[k] then
            return require('lazy.core.util')[k]
        end
        t[k] = require('utils.' .. k)

        return t[k]
    end,
})
