local function after_install()
    require('neo-tree').setup({
        close_if_last_window = true,
    })

    vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
end

local function install(use)
    use({
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
    })
end

local keys = {
    n = {
        name = 'Neotree',
        o = { '<cmd>Neotree<cr>', 'open' },
        t = { '<cmd>Neotree toggle<cr>', 'toggle' },
        b = { '<cmd>Neotree action=show source=buffers position=right toggle=true<cr>', 'toggle buffers' },
        f = { '<cmd>Neotree reveal<cr>', 'show current file' },
        g = { '<cmd>Neotree float git_status<cr>', 'git status' },
    },
}

return {
    after_install = after_install,
    install = install,
    keys = keys,
}
