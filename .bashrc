# PS1
export PS1="\W>"

# Envvars
export LANG=en_US.UTF-8
export PATH="~/bin:$HOME/go/bin/:$HOME/.cargo/bin:$PATH"
export GOPATH=$HOME"/go"
export EDITOR="nvim"

# fzf completion and keybinds
if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi

alias vim="nvim"
alias userctl="systemctl --user"
