#!/bin/sh

if type_exists 'brew'; then
    info "Updating Homebrew..."
    brew update
    [[ $? ]] && e_success "Done"

    info "Updating any existing Homebrew formulae..."
    brew upgrade
    [[ $? ]] && e_success "Done"

    info "Checking status of desired Homebrew formulae..."
    local list_formulae
    local -a missing_formulae
    local -a desired_formulae=(
        'git'
        'the_silver_searcher'
        'nvm'
    )

    for index in ${!desired_formulae[*]}
    do
        if ! formula_exists ${desired_formulae[$index]}; then
            # store the name (and options) of every missing formula
            missing_formulae=("${missing_formulae[@]}" "${desired_formulae[$index]}")
        fi
    done

    if [[ "$missing_formulae" ]]; then
        # convert the array of missing formula into a list of space-separate strings
        list_formulae=$( info "%s " "${missing_formulae[@]}" )

        info "Installing missing Homebrew formulae..."
        # install all missing formulae
        brew install $list_formulae

        [[ $? ]] && e_success "Done"
    fi

    # use latest rsync rather than out-dated OS X rsync
    # install separately from the main formulae list to fix gh-19
    brew install https://raw.github.com/Homebrew/homebrew-dupes/master/rsync.rb

    # remove outdated versions from the cellar
    brew cleanup
else
    info "\n"
    fail "Error: Homebrew not found."
    info "Aborting...\n"
    exit
fi
