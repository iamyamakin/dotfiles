return {
    'alexghergh/nvim-tmux-navigation',
    cond = vim.env.TMUX ~= nil,
    opts = {
        disable_when_zoomed = true,
    },
    keys = {
        { '<c-h>', '<cmd>NvimTmuxNavigateLeft<cr>', desc = 'Left window' },
        { '<c-j>', '<cmd>NvimTmuxNavigateDown<cr>', desc = 'Up window' },
        { '<c-k>', '<cmd>NvimTmuxNavigateUp<cr>', desc = 'Down window' },
        { '<c-l>', '<cmd>NvimTmuxNavigateRight<cr>', desc = 'Right window' },
    },
}
