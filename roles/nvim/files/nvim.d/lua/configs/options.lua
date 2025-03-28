vim.g.mapleader = ','

local options = {
    background = 'dark',
    backup = false,
    clipboard = 'unnamedplus',
    colorcolumn = '120',
    completeopt = 'menuone,noinsert,noselect',
    cursorline = true,
    expandtab = true,
    formatexpr = "v:lua.require('conform').formatexpr()",
    hidden = true,
    history = 5000,
    hlsearch = true,
    ignorecase = true,
    list = true,
    listchars = {
        conceal = '┊',
        eol = '↲',
        extends = '»',
        nbsp = '␣',
        precedes = '«',
        space = ' ',
        tab = '→→',
        trail = '·',
    },
    mouse = 'a',
    number = true,
    scrolloff = 7,
    shiftwidth = 4,
    shortmess = vim.opt.shortmess + { c = true },
    sidescrolloff = 7,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 4,
    termguicolors = false,
    updatetime = 400,
    wrap = false,
    writebackup = false,
}

for key, value in pairs(options) do
    vim.opt[key] = value
end
