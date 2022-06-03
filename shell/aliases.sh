# Enable aliases to be sudo’ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias ll="exa -l --icons"
alias la="exa -la --icons"
alias ~="cd ~"
alias dotfiles='cd $DOTFILES_PATH'
alias mines="cd ~/Code/mines"
alias code="cd ~/Code/"

# Git
alias gaa="git add -A"
alias gc='$DOTLY_PATH/bin/dot git commit'
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gd='$DOTLY_PATH/bin/dot git pretty-diff'
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force-with-lease"
alias gpsF="git push --force"
alias gpl="git pull --rebase --autostash"
alias gb="git branch"
alias gbda='git branch --no-color --merged | grep -vE "^(\+|\*|\s*(development|develop|devel|dev)\s*$)" | xargs -n 1 git branch -d'
alias gbDa='git branch | grep -v "^*" | xargs git branch -D'
alias gl='$DOTLY_PATH/bin/dot git pretty-log'

# Utils
alias k='kill -9'
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias o.='open .'
alias up='dot package update_all'
