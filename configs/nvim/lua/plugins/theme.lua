local function after_install() vim.cmd('colorscheme onedark') end

local function install(use) use('olimorris/onedarkpro.nvim') end

local keys = {
    u = {
        name = 'theme',
        d = { '<cmd>:lua vim.cmd(":colorscheme onedark")<cr>', 'toggle dark theme' },
        l = { '<cmd>:lua vim.cmd(":colorscheme onelight")<cr>', 'toggle light theme' },
    },
}

return {
    after_install = after_install,
    install = install,
    keys = keys,
}
