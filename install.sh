#!/bin/bash

source scripts/utils.sh
source configs/zsh/zshenv

info '--- Setup xdg ---'
source scripts/setup_xdg.sh

info '--- Setup git ---'
source scripts/setup_git.sh

info '--- Setup osx ---'
source scripts/setup_osx.sh

info '--- Setup brew ---'
source scripts/setup_brew.sh

info '--- Setup zsh ---'
source scripts/setup_zsh.sh

info '--- Setup lua ---'
source scripts/setup_lua.sh

info '--- Setup go ---'
source scripts/setup_go.sh

info '--- Setup python ---'
source scripts/setup_python.sh

info '--- Setup node ---'
source scripts/setup_node.sh

info '--- Setup deno ---'
source scripts/setup_deno.sh

success '--- Done ---'
