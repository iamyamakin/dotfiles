return {
    'ggml-org/llama.vim',
    enabled = true,
    dependencies = { 'folke/snacks.nvim' },
    init = function()
        vim.g.llama_config = {
            endpoint = 'http://127.0.0.1:8012/infill',
            enable_at_startup = false,
            show_info = false,
        }
    end,
    config = function()
        Snacks.toggle.new({
            id = 'llama_enabled',
            name = '🦙 Llama',
            get = function() return vim.g.llama_enabled or vim.g.llama_config.enable_at_startup end,
            set = function(state)
                vim.g.llama_enabled = state
                if state then
                    vim.cmd('LlamaEnable')
                else
                    vim.cmd('LlamaDisable')
                end
            end,
        }):map('<leader>aT')
    end,
}
