#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pkg='nvim ~/Scripts/pkglist.txt && nvim ~/Scripts/aurlist.txt'
alias pkgsw='nano ~/Scripts/pkglist.txt && nano ~/Scripts/aurlist.txt && bash ~/Scripts/install.sh'
alias pv='source ~/.venv/bin/activate'
alias conf='nano ~/.config/hypr/hyprland.conf'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias sched='python ~/SynologyDrive/Work/Useful\ Code/Scheduler/scheduler_v_4.py'

PS1='[\u@\h \W]\$ '

neofetch
