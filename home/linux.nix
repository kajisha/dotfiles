# linux.nix — Linux (non-NixOS) 固有の設定
# Ubuntu / Arch / Fedora など NixOS 以外の Linux で使う。
# username / homeDirectory は flake.nix → common.nix で設定済みのため、ここでは不要。
{ pkgs, ... }:

{
  # ---- Linux 専用パッケージ ------------------------------------
  home.packages = with pkgs; [
    pciutils   # lspci
    usbutils   # lsusb
  ];

  # ---- フォント ------------------------------------------------
  # ~/.nix-profile/share/fonts を fontconfig に認識させる。
  # 反映には `fc-cache -f` の実行が必要（home-manager switch 後に自動実行される）。
  fonts.fontconfig.enable = true;
}
