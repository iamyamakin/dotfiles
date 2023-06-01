local function after_install()
    require('Comment').setup()
    require('todo-comments').setup()
end

local function install(use)
    use('numToStr/Comment.nvim')
    use({
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
    })
end

local keys = {
    x = {
        name = 'todo comment',
        ['['] = { '<cmd>lua require("todo-comments").jump_prev()<cr>', 'prev' },
        [']'] = { '<cmd>lua require("todo-comments").jump_next()<cr>', 'next' },
        l = { '<cmd>TodoLocList<cr>', 'open location list' },
    },
}

return {
    after_install = after_install,
    install = install,
    keys = keys,
}
