return {
    'saghen/blink.cmp',
    version = '*',
    event = 'InsertEnter',
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
        appearance = {
            kind_icons = GlobalUtils.icons.kinds,
            nerd_font_variant = 'mono',
            use_nvim_cmp_as_default = false,
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
            menu = {
                draw = {
                    treesitter = { 'lsp' },
                },
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
    },
    opts_extend = {
        'sources.completion.enabled_providers',
        'sources.default',
    },
    config = function(_, opts)
        require('blink.cmp').setup(opts)
    end,
}
