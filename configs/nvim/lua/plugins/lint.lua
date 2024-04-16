local function install(use)
    use({
        'mfussenegger/nvim-lint',
        config = function()
            local lint = require('lint')

            lint.linters_by_ft = lint.linters_by_ft or {}
            -- lint.linters_by_ft['css'] = { 'stylelint' }
            -- lint.linters_by_ft['dockerfile'] = { 'hadolint' }
            -- lint.linters_by_ft['html'] = { 'tidy' }
            -- lint.linters_by_ft['javascript'] = { 'eslint' }
            -- lint.linters_by_ft['javascriptreact'] = { 'eslint' }
            -- lint.linters_by_ft['json'] = { 'jsonlint' }
            -- lint.linters_by_ft['lua'] = { 'luacheck' }
            lint.linters_by_ft['make'] = { 'cmakelint' }
            -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
            -- lint.linters_by_ft['sh'] = { 'shellcheck' }
            -- lint.linters_by_ft['typescript'] = { 'eslint' }
            -- lint.linters_by_ft['typescriptreact'] = { 'eslint' }
            -- lint.linters_by_ft['yaml'] = { 'yamllint' }
            -- lint.linters_by_ft['zsh'] = { 'shellcheck' }

            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

            vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function() require('lint').try_lint(nil, { ignore_errors = true }) end,
            })
        end,
    })
end

return {
    install = install,
}
