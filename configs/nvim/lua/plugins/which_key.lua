local keys = require('config').keys

local function after_all()
    require('which-key').register(keys, { prefix = '<leader>', mode = 'n' })
end

local function after_install()
    vim.opt.timeout = true
    vim.opt.timeoutlen = 500

    require('which-key').setup({
        operators = {},
    })
end

local function install(use)
    use('folke/which-key.nvim')
end

return {
    after_all = after_all,
    after_install = after_install,
    install = install,
}
