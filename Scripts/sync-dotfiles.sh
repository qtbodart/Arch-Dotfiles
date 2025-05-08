#!/bin/bash

# --------------------------
# Config
# --------------------------
DOTFILES="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Files/directories to track
FILES=(
    ".bashrc"
    ".zshrc"
    ".config/hypr/"
    ".config/waybar/"
    "Scripts"
    "Wallpapers/"
)

# --------------------------
# Stage files for commit
# --------------------------

echo $'\n'"###########################"
echo      "### ADDING DOTFILES ... ###"
echo      "###########################"$'\n'

for file in "${FILES[@]}"; do
    if [ -e "$HOME/$file" ]; then
        $DOTFILES add "$HOME/$file"
        echo "✅Added $file"
    else
        echo "⚠ Skipped $file (does not exist)"
    fi
done

# --------------------------
# Commit with message
# --------------------------
commit_msg="$1"
if [ -z "$commit_msg" ]; then
    commit_msg="Sync dotfiles - $(date)"
fi


echo $'\n'"#############################"
echo      "### COMMITTING CHANGES... ###"
echo      "#############################"$'\n'

$DOTFILES commit -m "$commit_msg"

# --------------------------
# Push
# --------------------------


echo $'\n'"#########################"
echo      "### PUSHING TO REMOTE ###"
echo      "#########################"$'\n'

$DOTFILES push

echo $'\n'"✅ Dotfiles synced successfully!"
