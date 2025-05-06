#!bin/bash

sudo pacman -Suy --noconfirm


echo $'\n'"#######################################"
echo      "### Installing official packages... ###"
echo      "#######################################"$'\n'

sudo pacman -S --needed --noconfirm $(< ~/Scripts/pkglist.txt)

if [ -f ~/Scripts/aurlist.txt ]; then
    echo $'\n'"##################################"
    echo      "### Installing AUR packages... ###"
    echo      "##################################"$'\n'
    paru -S --needed --noconfirm $(< ~/Scripts/aurlist.txt)
fi

echo $'\n'"Finished installing!"
