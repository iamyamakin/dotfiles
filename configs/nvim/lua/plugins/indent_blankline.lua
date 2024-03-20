local function after_install()
    require('ibl').setup()
end

local function install(use) use('lukas-reineke/indent-blankline.nvim') end

local keys = {
    I = {
        name = 'indent',
        t = { '<cmd>:lua vim.cmd(":IBLToggle")<cr>', 'toggle indent' },
    },
}

return {
    after_install = after_install,
    install = install,
    keys = keys,
}
