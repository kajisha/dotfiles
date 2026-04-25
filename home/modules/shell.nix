# modules/shell.nix — シェル設定
{ pkgs, lib, config, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion          = true;
    autosuggestion.enable     = true;
    syntaxHighlighting.enable = true;
    dotDir                    = config.home.homeDirectory;  # ホームディレクトリを明示（legacy 動作を固定）

    shellAliases = {
      ll   = "ls -lahF";
      la   = "ls -A";
      ".."  = "cd ..";
      "..." = "cd ../..";
      gs   = "git status";
      gd   = "git diff";
      gc   = "git commit";
      gp   = "git push";
      gl   = "git log --oneline --graph --decorate";
    };

    # initExtra → initContent に改名（home-manager master）
    initContent = ''
      ${lib.optionalString pkgs.stdenv.isDarwin ''
        if [ -x /opt/homebrew/bin/brew ]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -x /usr/local/bin/brew ]; then
          eval "$(/usr/local/bin/brew shellenv)"
        fi
      ''}

      # TODO: 既存の .zshrc のカスタム設定をここに移植してください
    '';
  };

  programs.direnv = {
    enable               = true;
    enableZshIntegration = true;
    nix-direnv.enable    = true;
  };

  programs.fzf = {
    enable               = true;
    enableZshIntegration = true;
    defaultOptions       = [ "--height 40%" "--border" "--reverse" ];
  };
}
