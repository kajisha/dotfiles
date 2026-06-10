# modules/shell.nix — シェル設定（fish メイン）
# fzf key bindings: programs.fzf.enableFishIntegration が自動設定するため手動不要
# zoxide: programs.zoxide.enableFishIntegration が自動設定
# starship: programs.starship.enableFishIntegration が自動設定
{ pkgs, lib, config, ... }:

{
  # ---- direnv（.envrc 自動読み込み）---------------------------
  programs.direnv = {
    enable                = true;
    enableFishIntegration = false;  # fish では hang するため無効化
    nix-direnv.enable     = true;
  };

  # ---- fzf（キーバインドは enableFishIntegration が自動設定）--
  programs.fzf = {
    enable                = true;
    enableFishIntegration = true;  # fzf --fish | source を自動追加（fzf_key_bindings 含む）
    defaultOptions        = [ "--height 40%" "--border" "--reverse" ];
  };

  # ---- zoxide（スマートな cd）---------------------------------
  programs.zoxide = {
    enable                = true;
    enableFishIntegration = true;  # zoxide init fish | source を自動追加
  };

  # ---- starship（プロンプト）----------------------------------
  programs.starship = {
    enable                = true;
    enableFishIntegration = true;  # starship init fish | source を自動追加
  };

  # ---- fish (メインシェル) ------------------------------------
  programs.fish = {
    enable = true;

    loginShellInit = ''
      # Nix デーモン（nix コマンド本体）の PATH
      if test -d /nix/var/nix/profiles/default/bin
        fish_add_path -gp /nix/var/nix/profiles/default/bin
      end
      set -gx NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"
      if test -e /etc/ssl/cert.pem
        set -gx NIX_SSL_CERT_FILE /etc/ssl/cert.pem
      end

      # home-manager のセッション変数をログインシェルで有効化
      if test -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.fish
        source $HOME/.nix-profile/etc/profile.d/hm-session-vars.fish
      end
    '';

    shellAliases = {
      ll  = "ls -lahF";
      la  = "ls -A";
      gs  = "git status";
      gd  = "git diff";
      gc  = "git commit";
      gp  = "git push";
      gl  = "git log --oneline --graph --decorate";
      cat = "bat --paging=never";
      nix-clean = "nix-collect-garbage -d && nix-store --gc && rm -rf ~/.cache/nix";
      nix-clean-safe = "nix-collect-garbage -d";
    };

    interactiveShellInit = ''
      # Nix daemon + home-manager profile の PATH
      # loginShellInit でも設定するが、Linux では対話シェルがログインシェルで
      # ない場合があるためここでも追加（fish_add_path は重複を自動排除）
      if test -d /nix/var/nix/profiles/default/bin
        fish_add_path -gp /nix/var/nix/profiles/default/bin
      end
      if test -d $HOME/.nix-profile/bin
        fish_add_path -gp $HOME/.nix-profile/bin
      end

      # GPG / SSH エージェント
      set -gx GPG_TTY (tty)
      if command -q gpgconf
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket 2>/dev/null)
      end

      # bun
      if test -d ~/.bun
        set -gx BUN_INSTALL "$HOME/.bun"
        fish_add_path $BUN_INSTALL/bin
      end

      # ghcup (Haskell)
      if test -d ~/.ghcup
        fish_add_path $HOME/.cabal/bin $HOME/.ghcup/bin
      end

      # opam (OCaml) — 必要な場合はコメントアウトを外す
      # source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

      # TODO: その他の設定をここに追記してください
      direnv hook fish | source
    '';
  };

}
