local formatters = {}

local function register(formatter)
    formatters[#formatters + 1] = formatter
    table.sort(formatters, function(a, b)
        return a.priority > b.priority
    end)
end

local function resolve(buf)
    local have_primary = false

    buf = buf or vim.api.nvim_get_current_buf()

    return vim.tbl_map(function(formatter)
        local sources = formatter.sources(buf)
        local active = #sources > 0 and (not formatter.primary or not have_primary)

        have_primary = have_primary or (active and formatter.primary) or false

        return setmetatable({
            active = active,
            resolved = sources,
        }, { __index = formatter })
    end, formatters)
end

local function enabled(buf)
    buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf

    local global_autoformat = vim.g.autoformat
    local buffer_autoformat = vim.b[buf].autoformat

    if buffer_autoformat ~= nil then
        return buffer_autoformat
    end

    return global_autoformat == nil or global_autoformat
end

local function info(buf)
    buf = buf or vim.api.nvim_get_current_buf()

    local global_autoformat = vim.g.autoformat == nil or vim.g.autoformat
    local buffer_autoformat = vim.b[buf].autoformat
    local is_enabled = enabled(buf)
    local lines = {
        '# Status',
        ('- [%s] global **%s**'):format(
            global_autoformat and 'x' or ' ',
            global_autoformat and 'enabled' or 'disabled'
        ),
        ('- [%s] buffer **%s**'):format(
            is_enabled and 'x' or ' ',
            buffer_autoformat == nil and 'inherit' or buffer_autoformat and 'enabled' or 'disabled'
        ),
    }
    local have = false

    for _, formatter in ipairs(resolve(buf)) do
        if #formatter.resolved > 0 then
            have = true
            lines[#lines + 1] = "\n# " .. formatter.name .. (formatter.active and ' ***(active)***' or '')
            for _, line in ipairs(formatter.resolved) do
                lines[#lines + 1] = ("- [%s] **%s**"):format(formatter.active and 'x' or ' ', line)
            end
        end
    end
    if not have then
        lines[#lines + 1] = "\n***No formatters available for this buffer.***"
    end
    GlobalUtils[is_enabled and 'info' or 'warn'](
        table.concat(lines, "\n"),
        { title = 'LazyFormat (' .. (is_enabled and 'enabled' or 'disabled') .. ')' }
    )
end

local function format(opts)
    opts = opts or {}

    local buf = opts.buf or vim.api.nvim_get_current_buf()

    if not ((opts and opts.force) or enabled(buf)) then
        return
    end

    local done = false

    for _, formatter in ipairs(resolve(buf)) do
        if formatter.active then
            done = true
            GlobalUtils.try(function()
                return formatter.format(buf)
            end, { msg = 'Formatter `' .. formatter.name .. '` failed' })
        end
    end

    if not done and opts and opts.force then
        GlobalUtils.warn('No formatter available', { title = 'GlobalUtils.format' })
    end
end

local function setup()
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LazyFormat', {}),
        callback = function(event)
            format({ buf = event.buf })
        end,
    })

    vim.api.nvim_create_user_command('LazyFormat', function()
        format({ force = true })
    end, { desc = 'Format selection or buffer' })

    vim.api.nvim_create_user_command('LazyFormatInfo', function()
        info()
    end, { desc = 'Show info about the formatters for the current buffer' })
end

return setmetatable({
    format = format,
    formatters = formatters,
    register = register,
    setup = setup,
}, {
    __call = function(m, ...)
        return m.format(...)
    end,
})
