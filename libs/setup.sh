#!/bin/sh

# check that packages can be compiled
if ! type_exists 'gcc'; then
    fail "The XCode Command Line Tools must be installed first."
    info "  Download them from: https://developer.apple.com/downloads\n"
    info "  Then run: bash ~/dotfiles/libs/setup.sh\n"
    exit 1
fi

# check for Homebrew
if ! type_exists 'brew'; then
    info "Installing Homebrew..."
    ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
fi

if ! type_exists 'git'; then
    info "Updating Homebrew..."
    brew update
    info "Installing Git..."
    brew install git
fi

source brew.sh
source npm.sh
