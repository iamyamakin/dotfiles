#!/bin/sh

lnif `pwd`/bash/.bash_profile ~/.bash_profile
if [ ! -d ~/.nvm ]; then
    git clone https://github.com/creationix/nvm.git ~/.nvm
fi
