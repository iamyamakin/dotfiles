#!/bin/sh

lnif `pwd`/git/.gitignore ~/.gitignore
printf "[include]\n\tpath = `pwd`/git/.gitconfig;\n" > ~/.gitconfig
