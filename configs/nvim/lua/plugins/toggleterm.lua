local function after_all()
    function _G.set_terminal_keymaps() vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0 }) end

    vim.cmd([[autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()]])
end

local function after_install()
    require('toggleterm').setup({
        open_mapping = [[<C-\>]],
    })
end

local function install(use) use('akinsho/toggleterm.nvim') end

return {
    after_all = after_all,
    after_install = after_install,
    install = install,
}
