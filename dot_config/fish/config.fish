# fish_default_key_bindings
# fzf_key_bindings

bind \cg ghq_cd
bind -M insert \cg ghq_cd

mise activate fish | source

starship init fish | source
zoxide init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx PATH /Users/h.kajisha/.local/bin $PATH

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/h.kajisha/.lmstudio/bin
# End of LM Studio CLI section

