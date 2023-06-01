#!/bin/bash

setup_brew() {
    if [[ ! $(command -v 'brew') ]]; then
        info 'Installing Homebrew...'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if [[ $(command -v 'brew') ]]; then
        info 'Updating Homebrew...'
        brew update

        info 'Updating any existing Homebrew formulae...'
        brew upgrade

        info 'Adding tap cask-fonts...'
        brew tap homebrew/cask-fonts

        info 'Checking status of desired Homebrew formulae...'

        local list_formulae
        local -a missing_formulae
        local -a desired_formulae=(
            'alacritty'
            'amethyst'
            'autocannon'
            'cmake'
            'docker'
            'firefox'
            'font-hack-nerd-font'
            'fzf'
            'git'
            'go'
            'google-chrome'
            'hadolint'
            'htop'
            'jq'
            'kubernetes-cli'
            'luarocks'
            'minikube'
            'neovim'
            'nmap'
            'node'
            'pure'
            'python3'
            'rar'
            'ripgrep'
            'rust'
            'shellcheck'
            'slack'
            'telegram'
            'tmux'
            'tree'
            'vlc'
            'wget'
            'zoom'
            'zsh'
            'zsh-autosuggestions'
            'zsh-completions'
        )
        local brew_list=$(brew list)
        local index

        for index in ${!desired_formulae[*]}; do
            local formulae="${desired_formulae[$index]}"

            if [[ ! $(mdfind "kMDItemKind == 'Application'" -onlyin "/Applications" | grep -i "$formulae") ]] && [[ ! $(echo "$brew_list" | grep -i "$formulae") ]] && [[ ! $(command -v "$formulae") ]]; then
                # store the name (and options) of every missing formula
                fail "Missing formula: $formulae"
                missing_formulae=("${missing_formulae[@]}" "$formulae")
            else
                info "$formulae already installed"
            fi
        done

        if [[ ${missing_formulae[@]} ]]; then
            # convert the array of missing formula into a list of space-separate strings
            list_formulae=$(printf "%s " "${missing_formulae[@]}")

            info 'Installing missing Homebrew formulae...'
            # install all missing formulae
            if [[ ! $(brew install $list_formulae) ]]; then
                fail 'Error: Homebrew formulae not installed.'
                info 'Aborting...\n'

                exit
            fi
        fi

        # remove outdated versions from the cellar
        brew cleanup
    else
        fail 'Error: Homebrew not found.'
        info 'Aborting...\n'

        exit
    fi
}

setup_brew
