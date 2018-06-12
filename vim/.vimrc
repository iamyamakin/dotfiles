set nocompatible
filetype off
set rtp+=~/dotfiles/vim/bundle/Vundle.vim/

call vundle#begin('~/dotfiles/vim/bundle/')
if filereadable(expand("~/dotfiles/vim/.bundles.vim"))
    source ~/dotfiles/vim/.bundles.vim
endif
call vundle#end()

filetype plugin indent on
syntax on

if filereadable(expand("~/dotfiles/vim/.common.vim"))
    source ~/dotfiles/vim/.common.vim
endif
