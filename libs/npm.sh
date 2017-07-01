#!/bin/sh

if type_exists 'npm'; then
    info "Installing Node.js packages..."

    # List of npm packages
    local packages="gify jshint yo"

    # Install packages globally and quietly
    npm install $packages --global --quiet

    [[ $? ]] && success "Done"
else
    info "\n"
    fail "Error: npm not found."
    info "Aborting...\n"
    exit
fi
