# fish_default_key_bindings
# fzf_key_bindings

~/.local/bin/mise activate fish | source

# export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
# export GPG_TTY=(tty)
# gpg-agent -q --daemon 2> /dev/null

~/.local/share/mise/shims/starship init fish | source
zoxide init fish | source

string match -q "$TERM_PROGRAM" "kiro" and . (kiro --locate-shell-integration-path fish)
