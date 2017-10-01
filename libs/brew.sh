#!/bin/sh

run_brew () {
    if type_exists 'brew'; then
        info "Updating Homebrew..."
        brew update
        [[ $? ]] && success "Done"

        info "Updating any existing Homebrew formulae..."
        brew upgrade
        [[ $? ]] && success "Done"

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
            local formulae=${desired_formulae[$index]}
            if ! formula_exists ${formulae}; then
                # store the name (and options) of every missing formula
                fail "Missing formula: ${formulae}"
                missing_formulae=("${missing_formulae[@]}" "${formulae}")
            else
                info "${formulae} already installed"
            fi
        done

        if [[ "$missing_formulae" ]]; then
            # convert the array of missing formula into a list of space-separate strings
            list_formulae=$( printf "%s " "${missing_formulae[@]}" )

            info "Installing missing Homebrew formulae..."
            # install all missing formulae
            brew install $list_formulae

            [[ $? ]] && success "Done"
        fi

        # remove outdated versions from the cellar
        brew cleanup
    else
        info "\n"
        fail "Error: Homebrew not found."
        info "Aborting...\n"
        exit
    fi
}

run_brew
