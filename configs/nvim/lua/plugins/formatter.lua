local function after_install()
    local prettier = require('formatter.defaults.prettier')
    local util = require('formatter.util')
    local eslint = {
        exe = 'eslint',
        args = {
            '--fix-dry-run',
            '--stdin',
            '--stdin-filename',
            util.escape_path(util.get_current_buffer_file_path()),
            try_node_modules = true,
        },
        stdin = true,
    }

    require('formatter').setup({
        filetype = {
            css = {
                prettier,
            },
            graphql = {
                prettier,
            },
            html = {
                prettier,
            },
            javascript = {
                prettier,
                eslint,
            },
            javascriptreact = {
                prettier,
                eslint,
            },
            json = {
                prettier,
                require('formatter.filetypes.json').jq,
            },
            lua = {
                require('formatter.filetypes.lua').stylua,
            },
            markdown = {
                prettier,
            },
            sh = {
                require('formatter.filetypes.sh').shfmt,
            },
            typescript = {
                prettier,
                eslint,
            },
            typescriptreact = {
                prettier,
                eslint,
            },
            yaml = {
                require('formatter.filetypes.yaml').yamlfmt,
            },
            zsh = {
                require('formatter.filetypes.sh').shfmt,
            },
        },
    })
end

local function install(use) use('mhartington/formatter.nvim') end

return {
    after_install = after_install,
    install = install,
}
