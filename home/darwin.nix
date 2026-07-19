# darwin.nix — macOS 固有の設定
# nix-darwin を使わない standalone home-manager 構成。
# username / homeDirectory は flake.nix → common.nix で設定済みのため、ここでは不要。
{ pkgs, lib, ... }:

{
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
    cmux         # Claude Code セッション管理: CLI + cmux.app (macOS のみ)
    slack        # チームコミュニケーション
    ssm-session-manager-plugin # AWS CLI Session Manager plugin (macOS のみ)
    ollama       # ローカル LLM (macOS では nixpkgs 標準の MLX 有効設定を使う)
    pinentry_mac # GPG 用パスフレーズ入力 (macOS)
  ];

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
