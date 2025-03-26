local supported = {}

return {
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = {
            ensure_installed = {
                'biome',
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
