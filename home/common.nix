# common.nix — 全プラットフォーム共通の設定
# username / homeDirectory は flake.nix の specialArgs から受け取る。
{ pkgs, lib, username, homeDirectory, ... }:

{
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/editor.nix
    ./modules/apps.nix
  ];

  # ---- 基本情報 ------------------------------------------------
  # flake.nix の mkHomeConfig で渡された値を使う（手動編集不要）
  home.username    = username;
  home.homeDirectory = homeDirectory;

  # home-manager のバージョン。初回設定後は変更しないこと。
  # アップグレード時は公式ドキュメントに従って段階的に上げる。
  home.stateVersion = "24.11";

  # ---- nixpkgs 設定 -------------------------------------------
  nixpkgs.config.allowUnfree = true;  # codeql / 1password-cli 等

  # ---- 環境変数 ------------------------------------------------
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG   = "ja_JP.UTF-8";
  };

  # ---- XDG ベースディレクトリ -----------------------------------
  xdg.enable = true;

  # home-manager 自身の管理を有効化
  programs.home-manager.enable = true;
}
