# fish_default_key_bindings
fzf_key_bindings

~/.local/bin/mise activate fish | source

export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=(tty)
gpg-agent -q --daemon 2> /dev/null

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/hiroshi/.ghcup/bin # ghcup-env

# opam configuration
# source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

~/.local/share/mise/shims/starship init fish | source
zoxide init fish | source
