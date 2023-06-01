local function after_install()
    require('lualine').setup({
        options = {
            globalstatus = true,
        },
    })
end

local function install(use)
    use({
        'nvim-lualine/lualine.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
    })
end

return {
    after_install = after_install,
    install = install,
}
