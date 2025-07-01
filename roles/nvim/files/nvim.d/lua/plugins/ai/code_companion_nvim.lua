return {
    'olimorris/codecompanion.nvim',
    url = 'git@github.com:olimorris/codecompanion.nvim.git',
    cmd = {
        'CodeCompanion',
        'CodeCompanionActions',
        'CodeCompanionAdd',
        'CodeCompanionChat',
        'CodeCompanionToggle',
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        adapters = {
            acp = {
                opts = {
                    show_defaults = false,
                },
            },
            http = {
                opts = {
                    show_defaults = false,
                },
                qwen = function()
                    return require('codecompanion.adapters.http').extend(
                        'openai_compatible',
                        {
                            name = 'qwen',
                            env = {
                                url = 'http://localhost:8012',
                            },
                        }
                    )
                end,
            },
        },
        display = {
            chat = {
                intro_message = 'Press ? for options',
            },
        },
        strategies = {
            chat = {
                adapter = {
                    name = 'qwen',
                    model = '',
                },
                roles = {
                    llm = function(adp)
                        local icon = '󰈔'

                        return string.format(
                            ' %s %s (%s)',
                            icon .. ' ',
                            adp.name,
                            adp.type == 'acp' and adp.formatted_name or adp.model.name
                        )
                    end,
                    user = vim.env.USER,
                },
                slash_commands = {
                    buffer = {
                        keymaps = {
                            modes = {
                                n = 'gb',
                            },
                        },
                    },
                },
            },
            cmd = {
                adapter = 'qwen',
            },
            inline = {
                adapter = 'qwen',
            },
        },
    },
    keys = {
        { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
        { '<leader>ap', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'Prompt Actions (CodeCompanion)' },
        { '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'Toggle (CodeCompanion)' },
        { '<leader>ac', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'Add code to CodeCompanion' },
        { '<leader>ai', '<cmd>CodeCompanion<cr>', mode = 'n', desc = 'Inline prompt (CodeCompanion)' },
    },
}
