local picker = {
    name = 'fzf',
    commands = {
        files = 'files',
    },
    open = function(command, opts)
        opts = opts or {}
        if opts.cmd == nil and command == 'git_files' and opts.show_untracked then
            opts.cmd = 'git ls-files --exclude-standard --cached --others'
        end

        return require('fzf-lua')[command](opts)
    end,
}

if not GlobalUtils.pick.register(picker) then
    return {}
end

local function get_kind_filter(buf)
    buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf

    local ft = vim.bo[buf].filetype

    if GlobalUtils.kind_filter[ft] == false then
        return
    end
    if type(GlobalUtils.kind_filter[ft]) == 'table' then
        return GlobalUtils.kind_filter[ft]
    end

    return type(GlobalUtils.kind_filter) == 'table'
            and type(GlobalUtils.kind_filter.default) == 'table'
            and GlobalUtils.kind_filter.default
        or nil
end

local function symbols_filter(entry, ctx)
    if ctx.symbols_filter == nil then
        ctx.symbols_filter = get_kind_filter(ctx.bufnr) or false
    end
    if ctx.symbols_filter == false then
        return true
    end

    return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
    {
        'ibhagwan/fzf-lua',
        event = 'VeryLazy',
        cmd = 'FzfLua',
        dependencies = { 'nvim-mini/mini.icons' },
        opts = function()
            local fzf = require('fzf-lua')
            local actions = fzf.actions
            local config = fzf.config

            config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
            config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
            config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
            config.defaults.keymap.fzf['ctrl-x'] = 'jump'
            config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
            config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
            config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
            config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

            config.defaults.actions.files['ctrl-t'] = require('trouble.sources.fzf').actions.open

            config.defaults.actions.files['ctrl-r'] = function(_, ctx)
                local o = vim.deepcopy(ctx.__call_opts)
                o.root = o.root == false
                o.cwd = nil
                o.buf = ctx.__CTX.bufnr
                GlobalUtils.pick.open(ctx.__INFO.cmd, o)
            end
            config.defaults.actions.files['alt-c'] = config.defaults.actions.files['ctrl-r']
            config.set_action_helpstr(config.defaults.actions.files['ctrl-r'], 'toggle-root-dir')

            local img_previewer = { 'chafa', '{file}', '--format=symbols' }

            return {
                'default-title',
                fzf_colors = true,
                fzf_opts = {
                    ['--no-scrollbar'] = true,
                },
                defaults = {
                    formatter = 'path.dirname_first',
                },
                previewers = {
                    builtin = {
                        extensions = {
                            ['png'] = img_previewer,
                            ['jpg'] = img_previewer,
                            ['jpeg'] = img_previewer,
                            ['gif'] = img_previewer,
                            ['webp'] = img_previewer,
                        },
                        ueberzug_scaler = 'fit_contain',
                    },
                },
                files = {
                    cwd_prompt = false,
                    actions = {
                        ['alt-i'] = { actions.toggle_ignore },
                        ['alt-h'] = { actions.toggle_hidden },
                    },
                },
                grep = {
                    actions = {
                        ['alt-i'] = { actions.toggle_ignore },
                        ['alt-h'] = { actions.toggle_hidden },
                    },
                },
                lsp = {
                    symbols = {
                        symbol_hl = function(s)
                            return 'TroubleIcon' .. s
                        end,
                        symbol_fmt = function(s)
                            return s:lower() .. '\t'
                        end,
                        child_prefix = false,
                    },
                    code_actions = {
                        previewer = 'codeaction_native',
                    },
                },
            }
        end,
        keys = {
            { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
            { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
            {
                '<leader>,',
                '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
                desc = 'Switch Buffer',
            },
            { '<leader>/', GlobalUtils.pick('live_grep'), desc = 'Grep (Root Dir)' },
            { '<leader>:', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
            { '<leader><space>', GlobalUtils.pick('files'), desc = 'Find Files (Root Dir)' },
            { '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Buffers' },
            { '<leader>fc', GlobalUtils.pick.config_files(), desc = 'Find Config File' },
            { '<leader>ff', GlobalUtils.pick('files'), desc = 'Find Files (Root Dir)' },
            { '<leader>fF', GlobalUtils.pick('files', { root = false }), desc = 'Find Files (cwd)' },
            { '<leader>fg', '<cmd>FzfLua git_files<cr>', desc = 'Find Files (git-files)' },
            { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Recent' },
            { '<leader>fR', GlobalUtils.pick('oldfiles', { cwd = vim.uv.cwd() }), desc = 'Recent (cwd)' },
            { '<leader>gc', '<cmd>FzfLua git_commits<CR>', desc = 'Commits' },
            { '<leader>gs', '<cmd>FzfLua git_status<CR>', desc = 'Status' },
            { '<leader>s"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
            { '<leader>sa', '<cmd>FzfLua autocmds<cr>', desc = 'Auto Commands' },
            { '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Buffer' },
            { '<leader>sc', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
            { '<leader>sC', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
            { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document Diagnostics' },
            { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Workspace Diagnostics' },
            { '<leader>sg', GlobalUtils.pick('live_grep'), desc = 'Grep (Root Dir)' },
            { '<leader>sG', GlobalUtils.pick('live_grep', { root = false }), desc = 'Grep (cwd)' },
            { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = 'Help Pages' },
            { '<leader>sH', '<cmd>FzfLua highlights<cr>', desc = 'Search Highlight Groups' },
            { '<leader>sj', '<cmd>FzfLua jumps<cr>', desc = 'Jumplist' },
            { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Key Maps' },
            { '<leader>sl', '<cmd>FzfLua loclist<cr>', desc = 'Location List' },
            { '<leader>sM', '<cmd>FzfLua man_pages<cr>', desc = 'Man Pages' },
            { '<leader>sm', '<cmd>FzfLua marks<cr>', desc = 'Jump to Mark' },
            { '<leader>sR', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
            { '<leader>sq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix List' },
            { '<leader>sw', GlobalUtils.pick('grep_cword'), desc = 'Word (Root Dir)' },
            { '<leader>sW', GlobalUtils.pick('grep_cword', { root = false }), desc = 'Word (cwd)' },
            { '<leader>sw', GlobalUtils.pick('grep_visual'), mode = 'x', desc = 'Selection (Root Dir)' },
            { '<leader>sW', GlobalUtils.pick('grep_visual', { root = false }), mode = 'x', desc = 'Selection (cwd)' },
            { '<leader>uC', GlobalUtils.pick('colorschemes'), desc = 'Colorscheme with Preview' },
            {
                '<leader>ss',
                function()
                    require('fzf-lua').lsp_document_symbols({
                        regex_filter = symbols_filter,
                    })
                end,
                desc = 'Goto Symbol',
            },
            {
                '<leader>sS',
                function()
                    require('fzf-lua').lsp_live_workspace_symbols({
                        regex_filter = symbols_filter,
                    })
                end,
                desc = 'Goto Symbol (Workspace)',
            },
        },
    },
    {
        'folke/todo-comments.nvim',
        optional = true,
        keys = {
            { '<leader>st', function() require('todo-comments.fzf').todo() end, desc = 'Todo' },
            {
                '<leader>sT',
                function() require('todo-comments.fzf').todo({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end,
                desc = 'Todo/Fix/Fixme'
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = function()
            local Keys = require('plugins.lsp.keymaps').get()

            vim.list_extend(Keys, {
                {
                    'gd',
                    '<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>',
                    desc = 'Goto Definition',
                    has = 'definition'
                },
                {
                    'gr',
                    '<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>',
                    desc = 'References',
                    nowait = true
                },
                {
                    'gI',
                    '<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>',
                    desc = 'Goto Implementation'
                },
                {
                    'gy',
                    '<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>',
                    desc = 'Goto T[y]pe Definition'
                },
            })
        end,
    },
}
