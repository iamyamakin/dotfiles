[ -f ~/.bashrc ] && . ~/.bashrc

export LC_ALL="en_US.UTF-8"
export LC_TIME="en_EN.UTF-8"
export GIT_EDITOR=vim
export CLICOLOR=1

export NVM_DIR="$HOME/.nvm"
if [[ -f $(which brew) && -d $(brew --prefix nvm) ]]; then
    source $(brew --prefix nvm)/nvm.sh;
fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

source ~/dotfiles/bash/.aliases
source ~/dotfiles/bash/completion/git-completion.bash
source ~/dotfiles/bash/completion/git-prompt.sh

PATH=/opt/local/bin:$PATH

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1

export PS1='\u@\h:\[\033[34m\]\W\[\033[0m\]\[\033[32m\]$(__git_ps1 "[%s]")\[\033[0m\]$ '

export TERM=xterm-256color
