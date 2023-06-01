local function after_install()
    local cmp = require('cmp')

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'buffer', keyword_length = 5 },
            { name = 'calc' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = 'path' },
            { name = 'luasnip' },
        },
    })
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })
end

local function install(use)
    -- engine
    use('hrsh7th/nvim-cmp')

    -- buffer
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-calc')

    -- command line
    use('hrsh7th/cmp-cmdline')

    -- lsp
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lsp-signature-help')

    -- misc
    use('hrsh7th/cmp-nvim-lua')

    -- paths
    use('hrsh7th/cmp-path')

    -- snippets
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
end

return {
    after_install = after_install,
    install = install,
}
