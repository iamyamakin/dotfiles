vim.keymap.set(
    'n',
    '<leader>ur',
    '<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>',
    { desc = 'Redraw / Clear hlsearch / Diff Update' }
)
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

vim.keymap.set('n', '<c-h>', '<c-w>h', { desc = 'Go to Left Window', remap = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { desc = 'Go to Lower Window', remap = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { desc = 'Go to Upper Window', remap = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { desc = 'Go to Right Window', remap = true })

vim.keymap.set('n', '<a-up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<a-down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<a-left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<a-right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

vim.keymap.set('n', '<c-s-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<c-s-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<c-s-j>', '<esc><cmd>m .+2<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<c-s-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<c-s-j>', ":<c-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<c-s-k>', ":<c-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

vim.keymap.set({ 'i', 'x', 'n', 's' }, '<c-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function() GlobalUtils.format({ force = true }) end, { desc = 'Format' })

vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

Snacks.toggle.option('list', { name = 'Listchars' }):map('<leader>uL')
Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>un')
Snacks.toggle.diagnostics():map('<leader>ud')
Snacks.toggle.line_number():map('<leader>ul')
Snacks.toggle
    .option('conceallevel', {
        off = 0,
        on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
        name = 'Conceal Level',
    })
    :map('<leader>uc')
Snacks.toggle
    .option('showtabline', { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = 'Tabline' })
    :map('<leader>uA')
Snacks.toggle.treesitter():map('<leader>uT')
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
Snacks.toggle.dim():map('<leader>uD')
Snacks.toggle.animate():map('<leader>ua')
Snacks.toggle.indent():map('<leader>ug')
Snacks.toggle.scroll():map('<leader>uS')
Snacks.toggle.profiler():map('<leader>dpp')
Snacks.toggle.profiler_highlights():map('<leader>dph')
Snacks.toggle.inlay_hints():map('<leader>uh')

vim.keymap.set(
    'n',
    '<c-\\>',
    function() Snacks.terminal(nil, { cwd = GlobalUtils.root.get() }) end,
    { desc = 'Terminal (Root Dir)' }
)
vim.keymap.set('t', '<c-\\>', '<cmd>close<cr>', { desc = 'Hide Terminal' })

vim.keymap.set('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
vim.keymap.set('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
