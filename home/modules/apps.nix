# modules/apps.nix — パッケージとアプリケーション設定
{ pkgs, ... }:

{
  # ---- パッケージ一覧 ------------------------------------------
  # NOTE: programs.* で管理するツール（git/gh/delta/eza/bat/neovim 等）は
  #       自動で home.packages に追加されるため、ここに重複して書かない。
  #
  # TODO: chezmoi で管理・手動インストールしていた追加ツールをここに書く。
  # パッケージ名検索: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # ---- CLI 必須ツール ----------------------------------------
    curl
    wget
    jq        # JSON 整形・クエリ
    yq-go     # YAML 整形・クエリ
    tree      # ディレクトリ構造表示
    htop      # プロセスモニター
    bottom    # モダンな top 代替 (btm コマンド)

    # ---- ファイル操作 ------------------------------------------
    ripgrep   # 高速 grep (rg コマンド)
    fd        # 高速 find — fd コマンド名で使う（find は上書きしない）

    # ---- 圧縮・展開 --------------------------------------------
    unzip
    zip

    # ---- その他 ------------------------------------------------
    # TODO: 追加で必要なパッケージをここに列挙してください
  ];

  # ---- starship プロンプト ------------------------------------
  # programs.starship は専用パッケージを自動でインストールする
  programs.starship = {
    enable               = true;
    enableZshIntegration = true;
    # enableFishIntegration = true;

    # TODO: 既存の starship.toml の設定をここに移植する
    # 変換の参考: https://starship.rs/config/
    settings = {
      add_newline = true;

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol   = "[❯](bold red)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo  = true;
      };

      git_branch.symbol = " ";
      git_status = {
        conflicted = "⚡";
        # starship の変数は $count / $ahead_count 形式。
        # Nix 文字列内では ${} 補間を回避するため \$ でエスケープする。
        ahead      = "⇡\${count}";
        behind     = "⇣\${count}";
        diverged   = "⇕⇡\${ahead_count}⇣\${behind_count}";
        modified   = "!";
        untracked  = "?";
        staged     = "+";
      };

      nix_shell = {
        disabled = false;
        symbol   = " ";
      };
    };
  };

  # ---- tmux ---------------------------------------------------
  programs.tmux = {
    enable       = true;
    shortcut     = "a";
    terminal     = "screen-256color";
    historyLimit = 10000;
    mouse        = true;

    # TODO: 既存の .tmux.conf の内容をここに移植する
    extraConfig = ''
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set -g status-position top
      setw -g mode-keys vi
    '';
  };

  # ---- eza (ls 代替) ------------------------------------------
  # programs.eza.enable が パッケージを自動インストールする（home.packages への追加不要）
  programs.eza = {
    enable               = true;
    enableZshIntegration = true;
    # enableFishIntegration = true;
    icons                = "auto";
    git                  = true;
    extraOptions         = [ "--group-directories-first" "--long" ];
  };

  # ---- bat (cat 代替) -----------------------------------------
  # programs.bat.enable がパッケージを自動インストールする（home.packages への追加不要）
  programs.bat = {
    enable = true;
    config = {
      theme        = "TwoDark";
      italic-text  = "always";
    };
  };

  # ---- SSH 設定 -----------------------------------------------
  # TODO: 設定を記述してから enable = true にする。
  #       enable = true のまま extraConfig が空だと既存の ~/.ssh/config と競合する可能性がある。
  programs.ssh = {
    enable = false;  # 設定を書き終えたら true に変更する
    # TODO: 既存の ~/.ssh/config の内容を移植する
    # extraConfig = ''
    #   Host github.com
    #     IdentityFile ~/.ssh/id_ed25519
    #     AddKeysToAgent yes
    # '';
  };
}
