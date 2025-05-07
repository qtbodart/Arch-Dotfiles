#!/bin/bash

# --------------------------
# Colors and symbols
# --------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CHECK="${GREEN}✅${NC}"
WARN="${YELLOW}⚠️ ${NC}"

PACKAGE_LIST="$HOME/Scripts/pkglist.txt"
AUR_LIST="$HOME/Scripts/aurlist.txt"

echo -e $'\n'"####################################"
echo      "### Updating current packages... ###"
echo -e "####################################"$'\n'

sudo pacman -Suy --noconfirm

# --------------------------
# Check if paru is installed, else install it
# --------------------------
if ! command -v paru &> /dev/null
then
    echo -e "$WARN paru is not installed, installing it now ..."

    if [ ! -d "$HOME/Packages" ]; then
        mkdir "$HOME/Packages"
    fi

    git clone https://aur.archlinux.org/paru.git "$HOME/Packages/paru"
    cd "$HOME/Packages/paru"
    makepkg -si --noconfirm
    cd ~
    rm -rf "$HOME/Packages/paru"
fi

# --------------------------
# Install official packages
# --------------------------
echo -e $'\n'"#######################################"
echo      "### Installing official packages... ###"
echo -e "#######################################"$'\n'

sudo pacman -S --needed --noconfirm $(< "$PACKAGE_LIST")

echo -e "$CHECK Finished installing official packages"

# --------------------------
# Install AUR packages (if list exists)
# --------------------------
if [ -f "$AUR_LIST" ]; then
    echo -e $'\n'"##################################"
    echo      "### Installing AUR packages... ###"
    echo -e "##################################"$'\n'

    paru -S --needed --noconfirm $(< "$AUR_LIST")

    echo -e "$CHECK Finished installing AUR packages"
fi

echo -e $'\n'"$CHECK Finished installing, enjoy!"
