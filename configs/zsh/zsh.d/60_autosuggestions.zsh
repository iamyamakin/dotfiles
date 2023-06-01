source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

bindkey '^[l' autosuggest-accept
bindkey '^[h' autosuggest-clear
bindkey '^[k' history-substring-search-up
bindkey '^j' history-substring-search-down

chmod -R go-w "$(brew --prefix)/share"
