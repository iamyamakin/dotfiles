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
        window = {
            mappings = {
                ['Y'] = function(state)
                    local node = state.tree:get_node()

                    if not node or not node.id then
                        vim.notify('No node selected.', vim.log.levels.WARN)
                        return
                    end

                    if vim.fn.has('clipboard') == 0 then
                        vim.notify('System clipboard is not available.', vim.log.levels.ERROR)
                        return
                    end

                    local filepath = node:get_id()
                    local filename = node.name
                    local modify = vim.fn.fnamemodify

                    local choices = {
                        { label = 'Absolute path', value = filepath },
                        { label = 'Path relative to CWD', value = modify(filepath, ':.') },
                        { label = 'Path relative to HOME', value = modify(filepath, ':~') },
                        { label = 'Filename', value = filename },
                        { label = 'Filename without extension', value = modify(filename, ':r') },
                        { label = 'Extension of the filename', value = modify(filename, ':e') },
                    }

                    require('snacks').picker.select(
                        choices,
                        {
                            prompt = 'Choose to copy to clipboard:',
                            format_item = function(item)
                                return string.format("%-30s %s", item.label, item.value)
                            end
                        },
                        function(choice)
                            if not choice then
                                vim.notify('Copy cancelled.', vim.log.levels.INFO)
                                return
                            end

                            local value_to_copy = choice.value

                            vim.fn.setreg('+', value_to_copy)
                            vim.notify('Copied to clipboard: ' .. value_to_copy)
                        end
                    )
                end,
            },
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
