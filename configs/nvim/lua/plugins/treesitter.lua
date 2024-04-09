local enabled_treesitter = require('config').enabled_treesitter

local function after_install()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })

    ts_update()

    require('nvim-treesitter.configs').setup({
        auto_install = true,
        ensure_installed = enabled_treesitter,
    })
end

local function install(use)
    use('nvim-treesitter/nvim-treesitter')
end

return {
    after_install = after_install,
    install = install,
}
