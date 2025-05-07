#!/bin/bash

set -e

DOTFILES_REPO="https://github.com/qtbodart/Arch-Dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

# Install git if needed
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    sudo pacman -Sy --noconfirm git
fi

# Clone dotfiles bare repo
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repo..."
    git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Setup dotfiles alias
alias dotfiles="/usr/bin/git --git-dir=$DOTFILES_DIR --work-tree=$HOME"

# Switch to SSH for future pushes
dotfiles remote set-url origin git@github.com:qtbodart/Arch-Dotfiles.git

# Checkout dotfiles
echo "Checking out dotfiles..."
dotfiles checkout -f
dotfiles config --local status.showUntrackedFiles no

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
