local picker = nil

local function register(new_picker)
    if picker and picker.name ~= new_picker.name then
        GlobalUtils.warn(
            '`GlobalUtils.pick`: picker already set to `' ..
            picker.name ..
            '`,\nignoring new picker `' ..
            new_picker.name ..
            '`'
        )

        return false
    end
    picker = new_picker

    return true
end

local function open(command, opts)
    if not picker then
        return GlobalUtils.error('GlobalUtils.pick: picker not set')
    end
    command = command ~= 'auto' and command or 'files'
    opts = opts or {}
    opts = vim.deepcopy(opts)
    if type(opts.cwd) == 'boolean' then
        GlobalUtils.warn('GlobalUtils.pick: opts.cwd should be a string or nil')
        opts.cwd = nil
    end
    if not opts.cwd and opts.root ~= false then
        opts.cwd = GlobalUtils.root.get({ buf = opts.buf })
    end
    command = picker.commands[command] or command
    picker.open(command, opts)
end

local function wrap(command, opts)
  opts = opts or {}

  return function()
    GlobalUtils.pick.open(command, vim.deepcopy(opts))
  end
end

local function config_files()
  return wrap('files', { cwd = vim.fn.stdpath('config') })
end

return setmetatable({
    config_files = config_files,
    open = open,
    register = register,
    wrap = wrap,
}, {
    __call = function(m, ...)
        return m.wrap(...)
    end,
})
