local function term_nav(dir)
    return function(self)
        return self:is_floating() and '<c-' .. dir .. '>' or vim.schedule(function() vim.cmd.wincmd(dir) end)
    end
end

return {
    'folke/snacks.nvim',
    optional = true,
    opts = {
        bigfile = {},
        dashboard = {
            preset = {
                pick = function(cmd, opts) return GlobalUtils.pick(cmd, opts)() end,
                header = [[

██╗     ███████╗████████╗███████╗     ██████╗ ███████╗████████╗     ██████╗  ██████╗ ██╗███╗   ██╗██╗
██║     ██╔════╝╚══██╔══╝██╔════╝    ██╔════╝ ██╔════╝╚══██╔══╝    ██╔════╝ ██╔═══██╗██║████╗  ██║██║
██║     █████╗     ██║   ███████╗    ██║  ███╗█████╗     ██║       ██║  ███╗██║   ██║██║██╔██╗ ██║██║
██║     ██╔══╝     ██║   ╚════██║    ██║   ██║██╔══╝     ██║       ██║   ██║██║   ██║██║██║╚██╗██║╚═╝
███████╗███████╗   ██║   ███████║    ╚██████╔╝███████╗   ██║       ╚██████╔╝╚██████╔╝██║██║ ╚████║██╗
╚══════╝╚══════╝   ╚═╝   ╚══════╝     ╚═════╝ ╚══════╝   ╚═╝        ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝

]],
                keys = {
                    { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
                    {
                        icon = ' ',
                        key = 'g',
                        desc = 'Find Text',
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                    },
                    {
                        icon = ' ',
                        key = 'r',
                        desc = 'Recent Files',
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = ' ',
                        key = 'c',
                        desc = 'Config',
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
                    { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
                    { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
                },
            },
        },
        explorer = {},
        gitbrowse = {},
        image = {},
        indent = {},
        input = {},
        notifier = {},
        picker = {},
        profiler = { pick = { picker = 'fzf-lua' } },
        quickfile = {},
        scope = {},
        scroll = {},
        terminal = {
            win = {
                keys = {
                    nav_h = { '<c-h>', term_nav('h'), desc = 'Go to Left Window', expr = true, mode = 't' },
                    nav_j = { '<c-j>', term_nav('j'), desc = 'Go to Lower Window', expr = true, mode = 't' },
                    nav_k = { '<c-k>', term_nav('k'), desc = 'Go to Upper Window', expr = true, mode = 't' },
                    nav_l = { '<c-l>', term_nav('l'), desc = 'Go to Right Window', expr = true, mode = 't' },
                },
            },
        },
        toggle = { map = GlobalUtils.safe_keymap_set },
        words = {},
    },
    keys = {
        { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
        { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
        { '<leader>dps', function() Snacks.profiler.scratch() end, desc = 'Profiler Scratch Buffer' },
        {
            '<leader>n',
            function()
                if Snacks.config.picker and Snacks.config.picker.enabled then
                    Snacks.picker.notifications()
                else
                    Snacks.notifier.show_history()
                end
            end,
            desc = 'Notification History',
        },
        { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
        { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
        { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse (open)', mode = { 'n', 'x' } },
        { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
        { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
        { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
        { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
        { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
        { '<leader>gD', function() Snacks.picker.git_diff({ base = "origin", group = true }) end, desc = 'Git Diff (Origin)' },
        { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },
    },
}
