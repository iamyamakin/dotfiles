#!/bin/bash
setup_xcode() {
    if [[ ! $(command -v 'xcode-select') ]]; then
        xcode-select --install
    fi
}

setup_screenshots() {
    local SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"

    if [[ ! -d "$SCREENSHOTS_DIR" ]]; then
        mkdir "$SCREENSHOTS_DIR"
        defaults write com.apple.screencapture location "$SCREENSHOTS_DIR" \
        && info "Screenshots will be saved to $SCREENSHOTS_DIR" \
        || fail "Error: Could not save screenshots to $SCREENSHOTS_DIR";
    fi
}

setup_xcode
setup_screenshots
