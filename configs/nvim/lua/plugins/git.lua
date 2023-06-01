local function after_install()
    require('gitsigns').setup({
        current_line_blame = true,
    })
end

local function install(use)
    use('tpope/vim-fugitive')
    use('tpope/vim-rhubarb')
    use('lewis6991/gitsigns.nvim')
end

local keys = {
    g = {
        name = 'git',
        C = { '<cmd>Git commit --amend<cr>', 'amend' },
        D = { '<cmd>Git diff<cr>', 'diff' },
        H = { '<cmd>Git hist<cr>', 'hist' },
        L = { '<cmd>Git log<cr>', 'log' },
        P = { '<cmd>Git push<cr>', 'push' },
        a = { '<cmd>Git add %<cr>', 'add current file' },
        b = { '<cmd>Git blame<cr>', 'blame' },
        c = { '<cmd>Git commit<cr>', 'commit' },
        d = { '<cmd>Gvdiffsplit!<cr>', 'diff current file' },
        h = { '<cmd>Git hist %<cr>', 'hist current file' },
        l = { '<cmd>Git log %<cr>', 'log current file' },
        p = { '<cmd>Git pull<cr>', 'pull' },
        s = { '<cmd>Git<cr>', 'status' },
    },
}

return {
    after_install = after_install,
    install = install,
    keys = keys,
}
