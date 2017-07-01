#!/bin/sh

source libs/utils.sh

echo ''
info 'Installing libs'
info '-------------------------------------------------'
source libs/setup.sh

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
