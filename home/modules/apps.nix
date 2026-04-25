# modules/apps.nix — パッケージとアプリケーション設定
{ pkgs, ... }:

{
  # ---- 環境変数 ------------------------------------------------
  home.sessionVariables = {
    GOPATH     = "$HOME/workspace";
    GOBIN      = "$HOME/workspace/bin";
    THOR_MERGE = "vimdiff";
  };

  # ---- Nix で管理するパッケージ --------------------------------
  home.packages = with pkgs; [
    # ---- CLI 必須ツール ----------------------------------------
    curl
    wget
    jq        # JSON 整形・クエリ
    yq-go     # YAML 整形・クエリ
    tree      # ディレクトリ構造表示
    bottom    # モダンな top 代替 (btm コマンド)

    # ---- ファイル操作 ------------------------------------------
    ripgrep   # 高速 grep (rg)
    fd        # 高速 find (fd)

    # ---- 圧縮・展開 --------------------------------------------
    unzip
    zip

    # ---- 言語ランタイム ----------------------------------------
    go          # Go（GOPATH は sessionVariables で設定）
    lua5_4      # Lua 5.4
    nodejs_20   # Node.js 20 LTS
    pnpm        # Node パッケージマネージャ
    python313   # Python 3.13
    ruby_3_3    # Ruby 3.3
    rustup      # Rust ツールチェーン管理（rustc / cargo を内包）

    # ---- クラウド・DevOps -------------------------------------
    awscli2           # AWS CLI v2
    codeql            # GitHub CodeQL 解析エンジン
    _1password-cli    # 1Password CLI (op コマンド)

    # ---- 開発ツール --------------------------------------------
    ghq     # Git リポジトリ管理
    opam    # OCaml パッケージマネージャ
  ];

  # ---- eza (ls 代替) ------------------------------------------
  programs.eza = {
    enable                = true;
    enableFishIntegration = true;
    icons                 = "auto";
    git                   = true;
    extraOptions          = [ "--group-directories-first" "--long" ];
  };

  # ---- tmux（ターミナルマルチプレクサ）-----------------------
  programs.tmux = {
    enable       = true;
    terminal     = "screen-256color";
    escapeTime   = 0;      # Esc 遅延をゼロに（Neovim 向け）
    historyLimit = 50000;
    mouse        = true;
    keyMode      = "vi";
  };

  # ---- bat (cat 代替) -----------------------------------------
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
