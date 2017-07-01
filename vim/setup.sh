#!/bin/sh

lnif `pwd`/vim/.vimrc ~/.vimrc
vim -v +PluginInstall +qall
