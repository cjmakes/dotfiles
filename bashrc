export PS1="\W>"

# nix
. /home/conner-jones/.nix-profile/etc/profile.d//nix.sh 
. /home/conner-jones/.netflixrc

# Path
[[ ":$PATH:" != *":$HOME/.kube/bin:"* ]] && export PATH="$HOME/.kube/bin:${PATH}"
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:${PATH}"
[[ ":$PATH:" != *":$HOME/go/bin:"* ]] && export PATH="$HOME/go/bin:${PATH}"

# fzf
eval "$(fzf --bash)"

# Env Vars
export EDITOR="nvim"
export GOPRIVATE=stash.corp.netflix.com

# Aliases
alias sway="systemd-cat --identifier=sway sway"
alias vim=nvim
alias userctl="systemctl --user"
alias gs='git status'
