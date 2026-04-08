local supported = {}

return {
    {
        'mason-org/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'biome',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                biome = {
                    root_dir = function(fname)
                        return require('lspconfig.util').root_pattern('biome.json', 'biome.jsonc')(fname)
                    end,
                },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            for _, ft in ipairs(supported) do
                opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
                table.insert(opts.formatters_by_ft[ft], 'biome')
            end

            opts.formatters = opts.formatters or {}
            opts.formatters.biome = {
                require_cwd = true,
            }
        end,
    },
}
