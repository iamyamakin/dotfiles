lnif "$DOTFILES_CONFIGS_DIR/zsh/zshenv" "$HOME/.zshenv"
lnif "$DOTFILES_CONFIGS_DIR/zsh/zshrc" "$HOME/.zshrc"

grep -qxF "$(which zsh)" /etc/shells || (echo $(which zsh) | sudo tee -a /etc/shells)
[[ $(which zsh) == $(echo $SHELL) ]] || chsh -s $(which zsh)
