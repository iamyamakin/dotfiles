vim.g.mapleader = ','

vim.keymap.set(
    'n',
    '<space>',
    ':nohlsearch<cr>',
    { desc = 'turn off highlight for last search', noremap = true, silent = true }
)
vim.keymap.set('n', 'L', ':set list!<cr>', { desc = 'toggle list mode', noremap = true, silent = true })
