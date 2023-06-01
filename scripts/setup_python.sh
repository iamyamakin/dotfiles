#!/bin/bash

setup_python() {
    if [[ $(command -v 'python3') ]]; then
        info 'Installing python3 packages...'

        if [[ ! $(pip3 list | grep pynvim) ]]; then
            pip3 install --user --upgrade pynvim
        fi

        pip3 install --user pre-commit
        pip3 install --user yamllint
    else
        fail 'Error: python3 not found'
        info 'Aborting...\n'

        exit
    fi
}

setup_python
