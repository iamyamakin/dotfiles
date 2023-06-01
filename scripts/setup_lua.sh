#!/bin/bash

setup_lua() {
    if [[ $(command -v 'luarocks') ]]; then
        info 'Installing Luarocks packages...'

        luarocks install luacheck
    else
        fail 'Error: luarocks not found'
        info 'Aborting...\n'

        exit
    fi
    if [[ $(command -v 'cargo') ]]; then
        info 'Installing cargo packages for lua...'

        cargo install stylua
    else
        fail 'Error: cargo for lua not found'
        info 'Aborting...\n'

        exit
    fi
}

setup_lua
