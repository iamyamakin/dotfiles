local function after_all()
    vim.cmd('au BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!')
    vim.cmd('au BufWinEnter ?* silent! loadview')
end

return {
    after_all = after_all,
}
