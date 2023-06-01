local function after_all()
    vim.keymap.set('n', '<leader>w', '<leader>fsv', { desc = 'search a word', remap = true })
    vim.keymap.set('n', '<leader>p', '<leader>ffp', { desc = 'search a path', remap = true })
end

local function after_install()
    require("fzf-lua").setup({
        lsp = {
            async_or_timeout = 3000,
        },
    })
end

local function install(use)
    use({
        'ibhagwan/fzf-lua',
        requires = 'nvim-tree/nvim-web-devicons',
    })
end

local keys = {
    f = {
        name = 'fzf',
        f = {
          name = 'buffers & files',
          b = { '<cmd>lua require("fzf-lua").buffers()<cr>', 'open buffers' },
          h = { '<cmd>lua require("fzf-lua").oldfiles()<cr>', 'opened files history' },
          p = { '<cmd>lua require("fzf-lua").files()<cr>', 'find or fd on a path' },
          q = { '<cmd>lua require("fzf-lua").quickfix()<cr>', 'quickfix list' },
          l = { '<cmd>lua require("fzf-lua").loclist()<cr>', 'location list' },
        },
        g = {
            name = 'git',
            b = { '<cmd>lua require("fzf-lua").git_branch()<cr>', 'git branches' },
            c = {
                name = 'commit log',
                c = { '<cmd>lua require("fzf-lua").git_commits()<cr>', 'git commit log (project)' },
                b = { '<cmd>lua require("fzf-lua").git_bcommits()<cr>', 'git commit log (buffer)' },
              },
            f = { '<cmd>lua require("fzf-lua").git_files()<cr>', 'git ls-files' },
            s = { '<cmd>lua require("fzf-lua").git_status()<cr>', 'git status' },
        },
        l = {
          name = 'lsp',
          D = { '<cmd>lua require("fzf-lua").lsp_workspace_diagnostics()<cr>', 'workspace diagnostics' },
          F = { '<cmd>lua require("fzf-lua").lsp_declarations()<cr>', 'declarations' },
          S = { '<cmd>lua require("fzf-lua").lsp_workspace_symbols()<cr>', 'workspace symbols' },
          a = { '<cmd>lua require("fzf-lua").lsp_code_actions()<cr>', 'code actions' },
          d = { '<cmd>lua require("fzf-lua").lsp_document_diagnostics()<cr>', 'document diagnostics' },
          f = { '<cmd>lua require("fzf-lua").lsp_definitions()<cr>', 'definitions' },
          i = { '<cmd>lua require("fzf-lua").lsp_implementations()<cr>', 'implementations' },
          r = { '<cmd>lua require("fzf-lua").lsp_references()<cr>', 'references' },
          t = { '<cmd>lua require("fzf-lua").lsp_typedefs()<cr>', 'type definitions' },
          s = { '<cmd>lua require("fzf-lua").lsp_document_symbols()<cr>', 'document symbols' },
        },
        m = {
          name = 'misc',
          H = { '<cmd>lua require("fzf-lua").search_history()<cr>', 'search history' },
          M = { '<cmd>lua require("fzf-lua").man_pages()<cr>', 'man pages' },
          R = { '<cmd>lua require("fzf-lua").registers()<cr>', 'registers' },
          b = { '<cmd>lua require("fzf-lua").builtin()<cr>', 'fzf-lua builtin methods' },
          c = { '<cmd>lua require("fzf-lua").colorschemes()<cr>', 'color schemes' },
          h = { '<cmd>lua require("fzf-lua").command_history()<cr>', 'commands history' },
          k = { '<cmd>lua require("fzf-lua").keymaps()<cr>', 'keymaps' },
          m = { '<cmd>lua require("fzf-lua").marks()<cr>', 'marks' },
          r = { '<cmd>lua require("fzf-lua").commands()<cr>', 'commands' },
          t = { '<cmd>lua require("fzf-lua").help_tags()<cr>', 'help tags' },
        },
        s = {
            name = 'search',
            C = { '<cmd>lua require("fzf-lua").grep_cWORD()<cr>', 'search WORD under cursor' },
            b = { '<cmd>lua require("fzf-lua").grep_curbuf()<cr>', 'search current buffer lines' },
            c = { '<cmd>lua require("fzf-lua").grep_cword()<cr>', 'search word under cursor' },
            g = { '<cmd>lua require("fzf-lua").grep()<cr>', 'search for a pattern with grep or rg' },
            l = { '<cmd>lua require("fzf-lua").grep_last()<cr>', 'run search again with the last pattern' },
            p = { '<cmd>lua require("fzf-lua").live_grep()<cr>', 'live grep current project' },
            v = { '<cmd>lua require("fzf-lua").grep_visual()<cr>', 'search visual selection' },
        },
    },
}

return {
    after_all = after_all,
    after_install = after_install,
    install = install,
    keys = keys,
}
