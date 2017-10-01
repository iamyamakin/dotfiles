#!/bin/sh

CURRENT_DIR=${BASH_SOURCE%/*}

# check that packages can be compiled
if ! type_exists 'gcc'; then
    fail "The XCode Command Line Tools must be installed first."
    info "  Download them from: https://developer.apple.com/downloads\n"
    info "  Then run: bash ~/dotfiles/libs/setup.sh\n"
    exit
fi

# check for Homebrew
if ! type_exists 'brew'; then
    info "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

source ${CURRENT_DIR}/brew.sh
source ${CURRENT_DIR}/node.sh
