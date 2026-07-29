# modules/editor.nix — エディタ設定（Neovim）
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
  ];

  home.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };

  # Neovim の Lua 設定と lazy.nvim のプラグイン定義を、一つの構成として管理する。
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/dot_config/nvim";
    force = true;
  };
}
