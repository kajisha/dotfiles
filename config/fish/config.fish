# fish_default_key_bindings

source ~/.asdf/asdf.fish

starship init fish | source

eval (asdf exec direnv hook fish)

export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=(tty)
gpg-agent -q --daemon 2> /dev/null
