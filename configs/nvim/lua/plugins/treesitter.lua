local enabled_treesitter = require('config').enabled_treesitter;

local function install(use)
    use({
        {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })

                ts_update()
            end,
            config = function()
                require('nvim-treesitter.configs').setup({
                    auto_install = true,
                    ensure_installed = enabled_treesitter,
                })
            end,
        },
        { 'nvim-treesitter/playground' },
    })
end

return {
    install = install,
}
