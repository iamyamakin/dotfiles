local function after_install()
    require('trouble').setup()
end

local function install(use)
    use({
        'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
    })
end

local keys = {
    T = {
      name = 'trouble',
      d = { '<cmd>Trouble document_diagnostics<cr>', 'document diagnostics' },
      l = { '<cmd>Trouble loclist<cr>', 'loclist' },
      q = { '<cmd>Trouble quickfix<cr>', 'quickfix' },
      r = { '<cmd>Trouble lsp_references<cr>', 'references' },
      t = { '<cmd>TroubleToggle<cr>', 'toggle' },
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'workspace diagnostics' },
    },
}

return {
    after_install = after_install,
    install = install,
    keys = keys,
}
