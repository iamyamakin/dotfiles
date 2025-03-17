_G.GlobalUtils = require('utils')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
    local out = vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazypath
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local function load(modname)
    if require('lazy.core.cache').find(modname)[1] then
        GlobalUtils.try(function()
            require(modname)
        end, { msg = 'Failed loading ' .. modname })
    end
end

local is_argc_empty = vim.fn.argc(-1) == 0

if not is_argc_empty  then
    load('configs.autocmds')
end

vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('', { clear = true }),
    pattern = 'VeryLazy',
    callback = function()
        if is_argc_empty then
            load('configs.autocmds')
        end
        load('configs.keymaps')
    end,
})

load('configs.options')

require('lazy').setup({
    spec = {
        { import = 'plugins.colorschemes' },
        { import = 'plugins.coding' },
        { import = 'plugins.editor' },
        { import = 'plugins.formatting' },
        { import = 'plugins.linting' },
        { import = 'plugins.lsp.mason' },
        { import = 'plugins.lsp.nvim_lspconfig' },
        { import = 'plugins.treesitter' },
        { import = 'plugins.langs' },
        { import = 'plugins.ui' },
        { import = 'plugins.misc' },
    },
    install = { colorscheme = { 'onedark_dark' } },
})

vim.cmd([[colorscheme onedark_dark]])
