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
  exit
}
lnif () {
    if [ -e $1 ]; then
        ln -sf $1 $2
    fi
}

echo ''
info 'Installing submodules'
info '-------------------------------------------------'
git submodule update --init

info 'Installing vim plugins'
info '-------------------------------------------------'
source vim/setup.sh

info 'Installing git environments'
info '-------------------------------------------------'
source git/setup.sh

info 'Installing bash environments'
info '-------------------------------------------------'
source bash/setup.sh

success 'All complete'
