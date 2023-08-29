local navigation = {}

local function after_all()
    vim.keymap.set('n', '<C-j>', navigation.navigate('down'), { desc = 'select down pane' })
    vim.keymap.set('n', '<C-h>', navigation.navigate('left'), { desc = 'select left pane' })
    vim.keymap.set('n', '<C-l>', navigation.navigate('right'), { desc = 'select right pane' })
    vim.keymap.set('n', '<C-k>', navigation.navigate('up'), { desc = 'select up pane' })

    vim.keymap.set('n', '<C-a>j', '<C-W>5-', { desc = 'resize active split height by -5 chars' })
    vim.keymap.set('n', '<C-a>k', '<C-W>5+', { desc = 'resize active split height by +5 chars' })
    vim.keymap.set('n', '<C-a>h', '<C-W>5<', { desc = 'resize active split width by -5 chars' })
    vim.keymap.set('n', '<C-a>l', '<C-W>5>', { desc = 'resize active split width by +5 chars' })
end

local function install(use)
    local keys = {
        align_equally = '=',
        down = {
            vim = 'j',
            tmux = 'D',
        },
        left = {
            vim = 'h',
            tmux = 'L',
        },
        right = {
            vim = 'l',
            tmux = 'R',
        },
        up = {
            vim = 'k',
            tmux = 'U',
        },
    }
    local layout_cmd = ''

    function navigation.align_equally()
        return function() vim.cmd('wincmd ' .. keys.align_equally) end
    end

    function navigation.navigate(direction)
        return function()
            if keys[direction] == nil then
                print('Unknown direction to navigate to "' .. direction .. '"')

                return nil
            end

            local winnr_before = vim.fn.winnr()

            if pcall(vim.cmd, 'wincmd ' .. keys[direction].vim) then
                if vim.fn.winnr() == winnr_before then
                    vim.cmd('silent ! tmux select-pane -' .. keys[direction].tmux)
                end
            else
                error('Cannot wincmd from the command-line window', 2)
            end
        end
    end
end

return {
    after_all = after_all,
    install = install,
}
