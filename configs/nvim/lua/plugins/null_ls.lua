local function after_install()
    local null_ls = require('null-ls')

    null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.shellcheck,

          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.luacheck,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.stylelint,
          null_ls.builtins.diagnostics.yamllint,

          null_ls.builtins.formatting.eslint,
          null_ls.builtins.formatting.jq,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.stylelint,
          null_ls.builtins.formatting.stylua,

          null_ls.builtins.hover.printenv,
        },
    })
end

local function install(use)
    use('jose-elias-alvarez/null-ls.nvim')
end

return {
    after_install = after_install,
    install = install,
}
