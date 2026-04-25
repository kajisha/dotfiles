# modules/apps.nix — パッケージとアプリケーション設定
# NOTE: 以下のツールは mise で管理されているため Nix では管理しない:
#   neovim, bat, starship, tmux, gh, go, node, rust, python, ruby, lua 等
#   → mise で管理するツールを重複して追加しないこと
{ pkgs, ... }:

{
  # ---- Nix で管理するパッケージ --------------------------------
  # mise と重複しないよう、mise に入っていないものだけを管理する。
  home.packages = with pkgs; [
    # ---- CLI 必須ツール ----------------------------------------
    curl
    wget
    jq        # JSON 整形・クエリ
    yq-go     # YAML 整形・クエリ
    tree      # ディレクトリ構造表示
    bottom    # モダンな top 代替 (btm コマンド)

    # ---- ファイル操作 ------------------------------------------
    ripgrep   # 高速 grep (rg) — mise で管理していない場合
    fd        # 高速 find (fd) — mise で管理していない場合

    # ---- 圧縮・展開 --------------------------------------------
    unzip
    zip

    # ---- TODO: mise に入っていない追加ツールをここに列挙 --------
  ];

  # ---- eza (ls 代替) ------------------------------------------
  programs.eza = {
    enable                = true;
    enableFishIntegration = true;
    icons                 = "auto";
    git                   = true;
    extraOptions          = [ "--group-directories-first" "--long" ];
  };

  # ---- bat (cat 代替) -----------------------------------------
  # mise で bat を管理している場合は enable = false にする
  programs.bat = {
    enable = true;
    config = {
      theme       = "TwoDark";
      italic-text = "always";
    };
  };

  # ---- SSH 設定 -----------------------------------------------
  # TODO: 設定を記述してから enable = true にする
  programs.ssh = {
    enable = false;
    # extraConfig = ''
    #   Host github.com
    #     IdentityFile ~/.ssh/id_ed25519
    #     AddKeysToAgent yes
    # '';
  };
}
