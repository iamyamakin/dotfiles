local function after_all()
    vim.cmd([[packadd which-key.nvim]])

    local which_key = require('which-key')
    local keys = require('config').keys

    which_key.register(keys, { prefix = '<leader>', mode = 'n' })
end

local function install(use)
    use({
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300

            require('which-key').setup({
                operators = {},
            })
        end,
    })
end

return {
    after_all = after_all,
    install = install,
}
