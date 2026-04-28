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
    nodejs_24   # Node.js 24 LTS
    pnpm        # Node パッケージマネージャ
    # python313 は下の withPackages 版で提供
    ruby_3_4    # Ruby 3.4
    rustup      # Rust ツールチェーン管理（rustc / cargo を内包）

    # ---- クラウド・DevOps -------------------------------------
    awscli2           # AWS CLI v2
    codeql            # GitHub CodeQL 解析エンジン
    _1password-cli    # 1Password CLI (op コマンド)

    # ---- 開発ツール --------------------------------------------
    ghq     # Git リポジトリ管理
    opam    # OCaml パッケージマネージャ

    # ---- AI コーディングエージェント ---------------------------
    codex       # OpenAI Codex CLI
    gemini-cli  # Google Gemini CLI

    # ---- mise default-npm-packages から移行 -----------------
    typescript          # tsc
    fx                  # JSON viewer
    biome               # @biomejs/biome
    tsx                 # TypeScript 実行ツール

    # ---- mise default-cargo-crates から移行 -----------------
    cargo-edit          # cargo add / rm / upgrade
    tree-sitter         # tree-sitter-cli
    mise                # rtx-cli の後継 (プロジェクト固有ツール用)
    # ripgrep / fd は上記で設定済み

    # ---- mise default-gems から移行 -------------------------
    solargraph          # Ruby LSP
    rubyPackages.standard  # Ruby リンタ
    # neovim gem は withRuby = false なので不要

    # ---- mise default-python-packages から移行 ---------------
    (python313.withPackages (ps: with ps; [ sqlparse ]))
    # neovim は withPython3 = false なので不要
    # awscli は上記 awscli2 で代用

    # ---- Homebrew から移行 ----------------------------------
    aws-sam-cli       # AWS SAM CLI
    azure-cli         # Azure CLI
    chezmoi           # dotfiles 管理（移行期間用、最終的には不要）
    cmake             # ビルドシステム
    ninja             # 高速ビルドシステム
    automake          # autotools
    libtool           # autotools
    entr              # ファイル変更で再実行
    ffmpeg            # 動画変換
    glow              # Markdown プレビュー
    ollama            # ローカル LLM
    pinentry_mac      # GPG 用パスフレーズ入力 (macOS)
    poppler           # PDF レンダリング
    socat             # ネットワークリレー
    sox               # 音声変換
    tig               # Git TUI
    watch             # 定期コマンド実行
    yadm              # Yet Another Dotfiles Manager
    # mactop は nixpkgs 側のパッケージ定義に HOME 不備があり sandbox で失敗するため Homebrew のまま

    # ---- フォント（Homebrew cask から移行）------------------
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];

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
