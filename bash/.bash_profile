[ -f ~/.bashrc ] && . ~/.bashrc

export LC_ALL="en_US.UTF-8"
export LC_TIME="en_EN.UTF-8"
export GIT_EDITOR=vim
export CLICOLOR=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

source ~/dotfiles/bash/.aliases
source ~/dotfiles/bash/completion/git-completion.bash
