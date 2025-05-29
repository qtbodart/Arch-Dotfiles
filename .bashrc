#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pkgsw='nano ~/.dotfiles/install/pkglist.txt && nano ~/.dotfiles/install/aurlist.txt && python ~/.dotfiles/install/Scripts/install_packages.py'
alias pv='source ~/.venv/bin/activate'
alias conf='nano ~/.config/hypr/hyprland.conf'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias sched='python ~/SynologyDrive/Work/Useful\ Code/Scheduler/scheduler_v_4.py'
alias pushdotfiles='python ~/.dotfiles/install/Scripts/sync_dotfiles.py'

PS1='[\u@\h \W]\$ '

neofetch
