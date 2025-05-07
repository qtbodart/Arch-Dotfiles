#!/bin/bash

DOTFILES_REPO="https://github.com/qtbodart/Arch-Dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

# Checkout dotfiles
echo "Checking out dotfiles..."
git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" checkout -f
git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" config --local status.showUntrackedFiles no

# Source shell config
if [ -f "$HOME/.bashrc" ]; then
    echo "Sourcing .bashrc..."
    source "$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    echo "Sourcing .zshrc..."
    source "$HOME/.zshrc"
fi

# Run installation script (packages)
if [ -f "$HOME/Scripts/install.sh" ]; then
    echo "Running package installer..."
    bash "$HOME/Scripts/install.sh"
fi

echo "✅ System bootstrap complete!"
