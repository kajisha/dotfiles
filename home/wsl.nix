# wsl.nix — WSL2 固有の追加設定
# linux.nix の上に重ねて読み込まれる。
{ ... }:

{
  # ---- WSL2 環境変数 -------------------------------------------
  home.sessionVariables = {
    # Windows のデフォルトブラウザを使う
    BROWSER = "/mnt/c/Windows/explorer.exe";
  };

  # ---- WSL2 でのサービス制限 ------------------------------------
  # WSL2 では systemd が制限されることがある。
  # 利用可否の確認: cat /proc/1/comm  → "systemd" なら有効
  # /etc/wsl.conf に [boot] systemd=true があれば有効
  #
  # systemd が使えない場合、以下で linux.nix のサービスを無効化できる:
  #   services.gpg-agent.enable = lib.mkForce false;
  # ただし linux.nix 側で enable = true にしてからでないと競合するため注意。
  # （linux.nix でコメントアウトを外した後、ここも有効化する）

  # ---- WSL2 での Git 改行コード ---------------------------------
  # git.nix で core.autocrlf = "input" が設定済みのため通常は不要。
  # Windows 側リポジトリで true に上書きしたい場合:
  #   programs.git.extraConfig.core.autocrlf = lib.mkForce "true";
}
