#!/bin/bash

setup_node() {
    if [[ $(command -v 'node') ]]; then
        info 'Installing Node.js packages...'

        # List of npm packages
        local packages='eslint jsonlint markdownlint-cli n prettier stylelint'

        # Install packages globally and quietly
        npm install $packages --global --quiet
    else
        fail 'Error: npm not found'
        info 'Aborting...\n'

        exit
    fi
}

setup_node
