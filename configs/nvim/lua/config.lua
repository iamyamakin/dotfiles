local enabled_plugins = {
    'nvim-lua/plenary.nvim',
    'plugins/which_key',
    'plugins/theme',
    'plugins/indent_blankline',
    'plugins/git',
    'plugins/lualine',
    'plugins/fzf',
    'plugins/editorconfig',
    'plugins/comment',
    'plugins/completion',
    'plugins/autopairs',
    'plugins/lsp',
    'plugins/tmux_navigation',
    'plugins/nvim_session',
    'plugins/neo_tree',
    'plugins/treesitter',
    'plugins/lint',
    'plugins/formatter',
    'plugins/trouble',
    'plugins/toggleterm',
    'plugins/surround',
}
local enabled_lsp_servers = {
    'ansiblels',
    'bashls',
    'cssls',
    'denols',
    'dockerls',
    'eslint',
    'gopls',
    'graphql',
    'html',
    'jqls',
    'jsonls',
    'lua_ls',
    'marksman',
    'rust_analyzer',
    'sqlls',
    'taplo',
    'tsserver',
    'vimls',
    'volar',
    'yamlls',
}
local enabled_treesitter = {
    'bash',
    'css',
    'dockerfile',
    'go',
    'graphql',
    'html',
    'javascript',
    'jq',
    'json',
    'lua',
    'markdown',
    'proto',
    'rust',
    'sql',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
}
local keys = {
    P = {
        name = 'packer',
        C = { '<cmd>PackerCompile<cr>', 'compile' },
        S = { '<cmd>PackerStatus<cr>', 'status' },
        c = { '<cmd>PackerClean<cr>', 'clean' },
        i = { '<cmd>PackerInstall<cr>', 'install' },
        s = { '<cmd>PackerSync<cr>', 'sync' },
        u = { '<cmd>PackerUpdate<cr>', 'update' },
    },
    t = {
        name = 'tabs',
        c = { '<cmd>tabclose<cr>', 'close' },
        e = { ':tabedit ', 'edit' },
        f = { '<cmd>tabfirst<cr>', 'first' },
        l = { '<cmd>tablast<cr>', 'last' },
        m = { ':tabmove ', 'move' },
        n = { '<cmd>tabnext<cr>', 'next' },
        p = { '<cmd>tabprevious<cr>', 'previous' },
        t = { '<cmd>tabnew<cr>', 'new' },
    }
}

return {
    enabled_lsp_servers = enabled_lsp_servers,
    enabled_plugins = enabled_plugins,
    enabled_treesitter = enabled_treesitter,
    keys = keys,
}
