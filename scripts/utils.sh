#!/bin/bash

function info() {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}

function success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

function fail() {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}

function lnif() {
    if [[ -e "$1" ]] && [[ ! -L "$2" ]]; then
        ln -s "$1" "$2" &> /dev/null
    fi
}
