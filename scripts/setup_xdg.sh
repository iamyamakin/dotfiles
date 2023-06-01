#!/bin/bash

[[ ! -d "$XDG_CACHE_HOME" ]] && mkdir -p "$XDG_CACHE_HOME"
[[ ! -d "$XDG_CONFIG_HOME" ]] && mkdir -p "$XDG_CONFIG_HOME"
[[ ! -d "$XDG_BIN_HOME" ]] && mkdir -p "$XDG_BIN_HOME"
[[ ! -d "$XDG_DATA_HOME" ]] && mkdir -p "$XDG_DATA_HOME"
[[ ! -d "$XDG_LIB_HOME" ]] && mkdir -p "$XDG_LIB_HOME"

[[ ! -d "$XDG_CACHE_HOME/luarocks" ]] && mkdir -p "$XDG_CACHE_HOME/luarocks"

[[ ! -d "$XDG_CONFIG_HOME/docker" ]] && mkdir -p "$XDG_CONFIG_HOME/docker"
[[ ! -d "$XDG_CONFIG_HOME/luarocks" ]] && mkdir -p "$XDG_CONFIG_HOME/luarocks"
[[ ! -d "$XDG_CONFIG_HOME/ripgrep" ]] && mkdir -p "$XDG_CONFIG_HOME/ripgrep"

[[ ! -d "$XDG_DATA_HOME/cargo" ]] && mkdir -p "$XDG_DATA_HOME/cargo"
[[ ! -d "$XDG_DATA_HOME/less" ]] && mkdir -p "$XDG_DATA_HOME/less"
[[ ! -d "$XDG_DATA_HOME/minikube" ]] && mkdir -p "$XDG_DATA_HOME/minikube/.minikube"
[[ ! -d "$XDG_DATA_HOME/n" ]] && mkdir -p "$XDG_DATA_HOME/n"
[[ ! -d "$XDG_DATA_HOME/node" ]] && mkdir -p "$XDG_DATA_HOME/node"
[[ ! -d "$XDG_DATA_HOME/tmux" ]] && mkdir -p "$XDG_DATA_HOME/tmux"
[[ ! -d "$XDG_DATA_HOME/zsh" ]] && mkdir -p "$XDG_DATA_HOME/zsh"

lnif "$DOTFILES_CONFIGS_DIR/alacritty/alacritty.yaml" "$XDG_CONFIG_HOME/alacritty.yml"
lnif "$DOTFILES_CONFIGS_DIR/efm-langserver/config.yaml" "$XDG_CONFIG_HOME/efm-langserver/config.yaml"
lnif "$DOTFILES_CONFIGS_DIR/git" "$XDG_CONFIG_HOME/git"
lnif "$DOTFILES_CONFIGS_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
lnif "$DOTFILES_CONFIGS_DIR/ripgrep/config" "$XDG_CONFIG_HOME/ripgrep/config"
lnif "$DOTFILES_CONFIGS_DIR/tmux" "$XDG_CONFIG_HOME/tmux"
