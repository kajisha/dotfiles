# darwin.nix — macOS 固有の設定
# nix-darwin を使わない standalone home-manager 構成。
# username / homeDirectory は flake.nix → common.nix で設定済みのため、ここでは不要。
{ pkgs, ... }:

{
  # ---- macOS 専用パッケージ ------------------------------------
  home.packages = with pkgs; [
    coreutils   # GNU coreutils (gls, gcat など)
    gnused
    gawk
    cmux         # Claude Code セッション管理 (macOS のみ)
    ssm-session-manager-plugin # AWS CLI Session Manager plugin (macOS のみ)
    ollama       # ローカル LLM (macOS では nixpkgs 標準の MLX 有効設定を使う)
    pinentry_mac # GPG 用パスフレーズ入力 (macOS)
  ];

  # ---- macOS デフォルト設定 ------------------------------------
  # NOTE: targets.darwin は nix-darwin が必要なため、
  #       standalone home-manager では使えない。
  #       macOS のシステム設定は defaults コマンドで別途行うか、
  #       nix-darwin 導入を検討してください。

  # ---- Homebrew との共存 ----------------------------------------
  # Homebrew PATH の設定は shell.nix の initExtra で isDarwin 条件付きに行う。
  # darwin.nix 単体では programs.zsh を上書きしないこと（OS レイヤーと機能レイヤーを分離）。
}
