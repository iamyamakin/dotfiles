return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    opts = {
        close_if_last_window = true,
        filesystem = {
            follow_current_file = {
                enabled = true,
            },
            use_libuv_file_watcher = true,
        },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    config = function(_, opts)
        local function on_move(data)
            Snacks.rename.on_rename_file(data.source, data.destination)
        end

        local events = require('neo-tree.events')
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
            { event = events.FILE_MOVED, handler = on_move },
            { event = events.FILE_RENAMED, handler = on_move },
        })
        require('neo-tree').setup(opts)
    end,
    keys = {
        {
            '<leader>fe',
            function()
                require('neo-tree.command').execute({ toggle = true, dir = GlobalUtils.root.get() })
            end,
            desc = 'Explorer NeoTree (Root Dir)',
        },
        {
            '<leader>fE',
            function()
                require('neo-tree.command').execute({ toggle = true, dir = GlobalUtils.root.cwd() })
            end,
            desc = 'Explorer NeoTree (cwd)',
        },
        { '<leader>e', '<leader>fe', desc = 'Explorer NeoTree (Root Dir)', remap = true },
        { '<leader>E', '<leader>fE', desc = 'Explorer NeoTree (cwd)', remap = true },
        {
            '<leader>ge',
            function()
                require('neo-tree.command').execute({ source = 'git_status', toggle = true })
            end,
            desc = 'Git Explorer',
        },
        {
            '<leader>be',
            function()
                require('neo-tree.command').execute({ source = 'buffers', toggle = true })
            end,
            desc = 'Buffer Explorer',
        },
    },
}
