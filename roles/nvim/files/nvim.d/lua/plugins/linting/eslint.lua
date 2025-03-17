local auto_format = true

return {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = {
        servers = {
            eslint = {
                settings = {
                    workingDirectories = { mode = 'auto' },
                    format = auto_format,
                },
            },
        },
        setup = {
            eslint = function()
                if not auto_format then
                    return
                end

                local formatter = GlobalUtils.lsp.formatter({
                    filter = 'eslint',
                    name = 'eslint: lsp',
                    primary = false,
                    priority = 200,
                })

                GlobalUtils.format.register(formatter)
            end,
        },
    },
}
