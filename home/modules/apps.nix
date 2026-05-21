# modules/apps.nix — パッケージとアプリケーション設定
{ pkgs, ... }:

let
  # microsoft/apm — Agent Package Manager (The NPM for AI-Native Development)
  # nixpkgs 未収録のため公式リリースバイナリ (PyInstaller) を直接パッケージング。
  # プラットフォーム4種対応: aarch64-darwin / x86_64-darwin / aarch64-linux / x86_64-linux
  msapm =
    let
      version = "0.14.0";
      platformSrc = {
        "aarch64-darwin" = {
          url    = "https://github.com/microsoft/apm/releases/download/v${version}/apm-darwin-arm64.tar.gz";
          sha256 = "3bb8b7ce7d4fc68646bfbe96c188e3c0cc278bfe066f68fb52e8929fd0da3938";
        };
        "x86_64-darwin" = {
          url    = "https://github.com/microsoft/apm/releases/download/v${version}/apm-darwin-x86_64.tar.gz";
          sha256 = "3f70f6c0985b344973f5ba6004f0bfc02212e547b95fdce04deb6d8a3ef7ae6d";
        };
        "aarch64-linux" = {
          url    = "https://github.com/microsoft/apm/releases/download/v${version}/apm-linux-arm64.tar.gz";
          sha256 = "3a8340b02851a94760a449d732e5f417b2ba4409689471302af9c5801851ad72";
        };
        "x86_64-linux" = {
          url    = "https://github.com/microsoft/apm/releases/download/v${version}/apm-linux-x86_64.tar.gz";
          sha256 = "5ca7853e4b8858272da721e1d68548a6c078f7920487298bef901bd6e709a7d1";
        };
      };
      src = platformSrc.${pkgs.stdenv.hostPlatform.system};
    in
    pkgs.stdenv.mkDerivation {
      pname   = "apm";
      inherit version;

      src = pkgs.fetchurl { inherit (src) url sha256; };

      dontConfigure = true;
      dontBuild     = true;
      dontStrip     = true;

      nativeBuildInputs =
        [ pkgs.makeWrapper ]
        ++ pkgs.lib.optionals pkgs.stdenv.isLinux [ pkgs.autoPatchelfHook ];

      # autoPatchelfHook が ELF の rpath を解決するために必要なランタイムライブラリ
      buildInputs = pkgs.lib.optionals pkgs.stdenv.isLinux [
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib
      ];

      installPhase = ''
        runHook preInstall

        mkdir -p $out/lib/apm $out/bin
        cp -r . $out/lib/apm/
        chmod +x $out/lib/apm/apm

        # PyInstaller の Python.framework は署名が曖昧で macOS の検証に失敗するため除去
        ${pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
          framework="$out/lib/apm/_internal/Python.framework/Python"
          if [ -f "$framework" ]; then
            /usr/bin/codesign --remove-signature "$framework" || true
          fi
        ''}

        # PyInstaller が _internal を実行バイナリの隣で探すため、
        # symlink ではなく makeWrapper (execスクリプト) でラップする
        makeWrapper $out/lib/apm/apm $out/bin/apm

        runHook postInstall
      '';

      meta = with pkgs.lib; {
        description = "Agent Package Manager: The NPM for AI-Native Development";
        homepage    = "https://github.com/microsoft/apm";
        license     = licenses.mit;
        mainProgram = "apm";
        platforms   = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ];
      };
    };
in

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
    msapm       # Microsoft Agent Package Manager (microsoft/apm)

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
