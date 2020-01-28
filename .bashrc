# PS1
export PS1="\W>"

# Envvars
export LANG=en_US.UTF-8
export PATH="~/bin:$HOME/go/bin/:$PATH"
export GOPATH=$HOME"/go"
export EDITOR="nvim"

# fzf completion and keybinds
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Functions
search-pkgs(){
  pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -r sudo \
    pacman -S --noconfirm
}

git-watcher(){
  while :; do
    clear; git status; sleep 1
  done
}

# Aliases
alias k='kubectl'
alias g='gcloud'
alias b="bazel"
alias ksrvs='while :; do; o=$(k get services); clear; echo "$o"; sleep 1; done'
alias kpods='while :; do k get pods; sleep 1; clear; done'
alias vim="nvim"
alias idea="_JAVA_AWT_WM_NONREPARENTING=1 idea" #Fixes intellij on sway
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
