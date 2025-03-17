return {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
        ensure_installed = {
            'gitleaks',
        },
    },
    opts_extend = { 'ensure_installed' },
    config = function(_, opts)
        require('mason').setup(opts)

        local mason_registry = require('mason-registry')

        mason_registry:on('package:install:success', function()
            vim.defer_fn(function()
                require('lazy.core.handler.event').trigger({
                    event = 'FileType',
                    buf = vim.api.nvim_get_current_buf(),
                })
            end, 100)
        end)

        mason_registry.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mason_registry.get_package(tool)

                if not p:is_installed() then
                    p:install()
                end
            end
        end)
    end,
}
