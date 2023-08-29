local merge_table = require('utils/merge_table').merge_table

local function run_plugins_hook(plugins_paths, hook, opts)
    if type(plugins_paths) ~= 'table' then error('You should specify the plugins_paths as a table', 2) end
    if type(hook) ~= 'string' then error('You should specify the hook as a string', 2) end

    local options = opts or {}

    for _, plugin_path in pairs(plugins_paths) do
        if type(plugin_path) ~= 'string' then error('You should specify the plugin_path as a string', 2) end

        local plugin_status, plugin = pcall(require, plugin_path)

        if plugin_status == false then
            if hook == 'install' then
                if type(options.use) == 'function' then options.use(plugin_path) end
            end
        elseif hook == 'keys' and type(plugin[hook]) == 'table' then
            merge_table(options.keys, plugin[hook])
        elseif type(plugin[hook]) == 'function' then
            plugin[hook](options.use)
        end
    end
end

return {
    run_plugins_hook = run_plugins_hook,
}
