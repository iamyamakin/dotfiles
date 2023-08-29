local function install(use)
    use({
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                css = { 'stylelint' },
                dockerfile = { 'hadolint' },
                html = { 'tidy' },
                javascript = { 'eslint' },
                javascriptreact = { 'eslint' },
                json = { 'jsonlint' },
                lua = { 'luacheck' },
                make = { 'cmakelint' },
                markdown = { 'markdownlint' },
                sh = { 'shellcheck' },
                typescript = { 'eslint' },
                typescriptreact = { 'eslint' },
                yaml = { 'yamllint' },
                zsh = { 'shellcheck' },
            }
            vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
                callback = function()
                    require("lint").try_lint(nil, { ignore_errors = true })
                end,
            })
        end
    })
end

return {
    install = install,
}
