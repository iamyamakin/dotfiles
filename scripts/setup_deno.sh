#!/bin/bash

setup_deno() {
    if [[ $(command -v 'deno') ]]; then
        info 'Installing Deno packages...'
    else
        fail 'Error: packages not found'
        info 'Aborting...\n'

        exit
    fi
}

setup_deno
