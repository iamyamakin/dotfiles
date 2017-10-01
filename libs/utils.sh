#!/bin/sh

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}
success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}
fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
}
lnif () {
    if [ -e $1 ]; then
        ln -sf $1 $2
    fi
}
type_exists () {
    if [ $(type -P $1) ]; then
        return 0
    fi
    return 1
}
formula_exists () {
    if $(brew list $1 >/dev/null); then
        return 0
    fi

    return 1
}
