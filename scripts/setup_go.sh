#!/bin/bash

setup_go() {
    if [[ $(command -v 'go') ]]; then
        info 'Installing Go packages...'

        go install mvdan.cc/sh/v3/cmd/shfmt@latest
        go install github.com/google/yamlfmt/cmd/yamlfmt@latest
    else
        fail 'Error: go not found'
        info 'Aborting...\n'

        exit
    fi
}

setup_go
