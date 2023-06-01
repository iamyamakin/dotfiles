local function after_install()
    require('nvim-autopairs').setup({
        check_ts = true,
        ts_config = {
            javascript = { 'template_string' },
            lua = { 'string' },
        },
    })
end

local function install(use)
    use('windwp/nvim-autopairs')
end

return {
    after_install = after_install,
    install = install,
}
