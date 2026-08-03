# darwin.nix — macOS 固有の設定
# nix-darwin を使わない standalone home-manager 構成。
# username / homeDirectory は flake.nix → common.nix で設定済みのため、ここでは不要。
{ pkgs, lib, homeDirectory, ... }:

let
  localMemoryDir = "${homeDirectory}/mem0-deploy";
  plistFormat = pkgs.formats.plist { };
  startLocalMemoryMcp = pkgs.writeShellScript "start-local-memory-mcp" ''
    until ${pkgs.curl}/bin/curl --fail --silent --max-time 2 \
      http://127.0.0.1:11434/api/tags >/dev/null; do
      sleep 2
    done

    exec ${localMemoryDir}/.venv/bin/python \
      ${localMemoryDir}/src/local_mcp_server.py
  '';
in {
  # ---- macOS アプリ bundle ------------------------------------
  # home.packages に含まれる *.app を ~/Applications/Home Manager Apps にリンクする。
  targets.darwin.linkApps = {
    enable = true;
    directory = "Applications/Home Manager Apps";
  };

  # ---- macOS 専用パッケージ ------------------------------------
  home.packages = with pkgs; [
    coreutils   # GNU coreutils (gls, gcat など)
    gnused
    gawk
    colima       # Docker Desktop 代替のローカルコンテナランタイム
    docker       # Docker CLI
    docker-compose # Docker Compose v2 plugin
    docker-buildx  # BuildKit / buildx plugin
    aerospace      # i3-like tiling window manager
    cmux         # Claude Code セッション管理: CLI + cmux.app (macOS のみ)
    slack        # チームコミュニケーション
    ssm-session-manager-plugin # AWS CLI Session Manager plugin (macOS のみ)
    ollama       # ローカル LLM (macOS では nixpkgs 標準の MLX 有効設定を使う)
    pinentry_mac # GPG 用パスフレーズ入力 (macOS)
  ];

  # ---- Local Mem0 ------------------------------------------------
  # Local Mem0 は起動時に Ollama のモデル一覧へ接続するため、Ollama を
  # LaunchAgent として常駐させ、MCP 側は readiness を待ってから起動する。
  home.file."Library/LaunchAgents/ai.ollama.local.plist".source =
    plistFormat.generate "ai.ollama.local.plist" {
      Label = "ai.ollama.local";
      ProgramArguments = [
        "${pkgs.ollama}/bin/ollama"
        "serve"
      ];
      EnvironmentVariables = {
        HOME = homeDirectory;
        OLLAMA_HOST = "127.0.0.1:11434";
      };
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Background";
      StandardOutPath = "${homeDirectory}/Library/Logs/ollama.out.log";
      StandardErrorPath = "${homeDirectory}/Library/Logs/ollama.err.log";
    };

  home.file."Library/LaunchAgents/ai.mem0.local-mcp.plist".source =
    plistFormat.generate "ai.mem0.local-mcp.plist" {
      Label = "ai.mem0.local-mcp";
      ProgramArguments = [ "${startLocalMemoryMcp}" ];
      WorkingDirectory = localMemoryDir;
      EnvironmentVariables = {
        LOCAL_MEM0_DATA_DIR = "${homeDirectory}/.local/share/mem0-oss/personal";
        LOCAL_MEM0_USER_ID = "hiroshi";
        MEM0_TELEMETRY = "false";
      };
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Background";
      StandardOutPath = "${homeDirectory}/Library/Logs/local-mem0-mcp.out.log";
      StandardErrorPath = "${homeDirectory}/Library/Logs/local-mem0-mcp.err.log";
    };

  # ---- AeroSpace ------------------------------------------------
  # Corne で押しやすい単一 Control 中心の操作。Ctrl+J は macSKK と
  # 競合するため使わない。設定の省略値は AeroSpace の上流既定に従う。
  xdg.configFile."aerospace/aerospace.toml".text = ''
    config-version = 2
    start-at-login = true

    default-root-container-layout = 'tiles'
    default-root-container-orientation = 'auto'
    accordion-padding = 0
    persistent-workspaces = ['1', '2', '3', '4', '5', '7', '8', '9']

    on-focused-monitor-changed = ['move-mouse monitor-lazy-center']

    gaps.inner.horizontal = 0
    gaps.inner.vertical = 0
    gaps.outer.left = 0
    gaps.outer.bottom = 0
    gaps.outer.top = 0
    gaps.outer.right = 0

    [workspace-to-monitor-force-assignment]
    7 = 'JAPANNEXT MNT'
    8 = 'JAPANNEXT MNT'
    9 = 'JAPANNEXT MNT'

    [mode.main.binding]
    ctrl-h = 'focus left'
    ctrl-k = 'focus up'
    ctrl-n = 'focus down'
    ctrl-l = 'focus right'

    ctrl-shift-h = 'move left'
    ctrl-shift-k = 'move up'
    ctrl-shift-n = 'move down'
    ctrl-shift-l = 'move right'

    ctrl-slash = 'layout tiles horizontal vertical'
    ctrl-minus = 'resize smart -50'
    ctrl-equal = 'resize smart +50'

    ctrl-1 = 'workspace 1'
    ctrl-2 = 'workspace 2'
    ctrl-3 = 'workspace 3'
    ctrl-4 = 'workspace 4'
    ctrl-5 = 'workspace 5'
    ctrl-7 = 'workspace 7'
    ctrl-8 = 'workspace 8'
    ctrl-9 = 'workspace 9'

    ctrl-shift-1 = 'move-node-to-workspace 1'
    ctrl-shift-2 = 'move-node-to-workspace 2'
    ctrl-shift-3 = 'move-node-to-workspace 3'
    ctrl-shift-4 = 'move-node-to-workspace 4'
    ctrl-shift-5 = 'move-node-to-workspace 5'
    ctrl-shift-7 = 'move-node-to-workspace 7'
    ctrl-shift-8 = 'move-node-to-workspace 8'
    ctrl-shift-9 = 'move-node-to-workspace 9'

    ctrl-tab = 'workspace-back-and-forth'
    ctrl-shift-tab = 'move-workspace-to-monitor --wrap-around next'
    ctrl-shift-semicolon = 'mode service'

    [mode.service.binding]
    esc = ['reload-config', 'mode main']
    r = ['flatten-workspace-tree', 'mode main']
    f = ['layout floating tiling', 'mode main']
    backspace = ['close-all-windows-but-current', 'mode main']
    h = ['join-with left', 'mode main']
    k = ['join-with up', 'mode main']
    n = ['join-with down', 'mode main']
    l = ['join-with right', 'mode main']
  '';

  # ---- macSKK 辞書 ---------------------------------------------
  # macSKK は App Sandbox 内の実ファイルを読むため、Nix store への
  # シンボリックリンクではなく activation 時に辞書をコピーする。
  home.activation.configureMacSKKDictionary = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    dictionary_dir="$HOME/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries"
    dictionary_file="$dictionary_dir/SKK-JISYO.L"
    preferences_domain="net.mtgto.inputmethod.macSKK"
    preferences="$HOME/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Library/Preferences/net.mtgto.inputmethod.macSKK.plist"
    source_dictionary="${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L"

    dictionary_needs_update=false
    preferences_need_update=false
    preferences_temp_dir=""
    if [[ -f "$preferences" ]]; then
      preferences_temp_dir=$(/usr/bin/mktemp -d -t macskk-preferences)
      preferences_snapshot="$preferences_temp_dir/preferences.plist"
      /usr/bin/defaults export "$preferences_domain" "$preferences_snapshot"
      current_dictionaries=$(/usr/bin/plutil -extract dictionaries json -o - "$preferences_snapshot" 2>/dev/null || echo '[]')
      updated_dictionaries=$(printf '%s' "$current_dictionaries" | ${pkgs.jq}/bin/jq -c '
        [.[] | select(.filename != "SKK-JISYO.L")]
        + [{
          filename: "SKK-JISYO.L",
          enabled: true,
          encoding: 3,
          type: "traditional",
          saveToUserDict: true
        }]
      ')

      if [[ "$(printf '%s' "$current_dictionaries" | ${pkgs.jq}/bin/jq -cS .)" != "$(printf '%s' "$updated_dictionaries" | ${pkgs.jq}/bin/jq -cS .)" ]]; then
        preferences_need_update=true
      fi
    fi

    if [[ ! -f "$dictionary_file" ]] || ! cmp -s "$source_dictionary" "$dictionary_file"; then
      dictionary_needs_update=true
    fi

    if [[ "$dictionary_needs_update" == true || "$preferences_need_update" == true ]]; then
      macskk_was_running=false
      if /usr/bin/pgrep -x macSKK >/dev/null; then
        macskk_was_running=true
        $DRY_RUN_CMD /usr/bin/killall macSKK
      fi

      $DRY_RUN_CMD mkdir -p "$dictionary_dir"
      if [[ "$dictionary_needs_update" == true ]]; then
        $DRY_RUN_CMD install -m 0644 "$source_dictionary" "$dictionary_file"
      fi

      if [[ "$preferences_need_update" == true ]]; then
        if /usr/bin/plutil -extract dictionaries raw -o /dev/null "$preferences_snapshot" 2>/dev/null; then
          $DRY_RUN_CMD /usr/bin/plutil -replace dictionaries -json "$updated_dictionaries" "$preferences_snapshot"
        else
          $DRY_RUN_CMD /usr/bin/plutil -insert dictionaries -json "$updated_dictionaries" "$preferences_snapshot"
        fi
        $DRY_RUN_CMD /usr/bin/defaults import "$preferences_domain" "$preferences_snapshot"
      fi

      if [[ "$macskk_was_running" == true ]]; then
        $DRY_RUN_CMD /usr/bin/open "/Library/Input Methods/macSKK.app"
      fi
    fi

    if [[ -n "$preferences_temp_dir" ]]; then
      /bin/rm -f "$preferences_snapshot"
      /bin/rmdir "$preferences_temp_dir"
    fi
  '';

  # ---- macOS デフォルト設定 ------------------------------------
  # NOTE: targets.darwin は nix-darwin が必要なため、
  #       standalone home-manager では使えない。
  #       macOS のシステム設定は defaults コマンドで別途行うか、
  #       nix-darwin 導入を検討してください。

  # ---- Homebrew との共存 ----------------------------------------
  # Homebrew PATH の設定は shell.nix の initExtra で isDarwin 条件付きに行う。
  # darwin.nix 単体では programs.zsh を上書きしないこと（OS レイヤーと機能レイヤーを分離）。
}
