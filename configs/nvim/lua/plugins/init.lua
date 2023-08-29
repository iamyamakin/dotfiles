local function install_packer()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd([[packadd packer.nvim]])

        return true
    end

    return false
end

local run_plugins_hook = require('utils/run_plugins_hook').run_plugins_hook
local enabled_plugins = require('config').enabled_plugins
local keys = require('config').keys
local packer_installed = install_packer()
local packer = require('packer')

run_plugins_hook(enabled_plugins, 'before_all')

packer.startup(function(use)
    use('wbthomason/packer.nvim')
    run_plugins_hook(enabled_plugins, 'install', { use = use })
    run_plugins_hook(enabled_plugins, 'after_install')
    run_plugins_hook(enabled_plugins, 'keys', { keys = keys })
    if packer_installed then require('packer').sync() end
end)

run_plugins_hook(enabled_plugins, 'after_all')
