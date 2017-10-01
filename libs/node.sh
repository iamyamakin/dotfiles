#!/bin/sh

init_nvm () {
    if formula_exists 'nvm'; then
        export NVM_DIR="$HOME/.nvm"
        source "$(brew --prefix nvm)/nvm.sh"

        info "Installing latest Node.js version..."

        nvm install node

        [[ $? ]] && success "Done"
    else
        info "\n"
        fail "Error: nvm not found"
        info "Aborting...\n"
        exit
    fi
}

run_npm () {
    if type_exists 'npm'; then
        info "Installing Node.js packages..."

        # List of npm packages
        local packages="eslint yarn"

        # Install packages globally and quietly
        npm install $packages --global --quiet

        [[ $? ]] && success "Done"
    else
        info "\n"
        fail "Error: npm not found"
        info "Aborting...\n"
        exit
    fi
}

init_nvm
run_npm
