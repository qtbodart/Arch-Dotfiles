#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pkg='nvim ~/Scripts/pkglist.txt && nvim ~/Scripts/aurlist.txt'
alias pkgsw='nvim ~/Scripts/pkglist.txt && nvim ~/Scripts/aurlist.txt && bash ~/Scripts/install.sh'
alias conf='nvim ~/.config/hypr/hyprland.conf'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
PS1='[\u@\h \W]\$ '
