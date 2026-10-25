{
  description = "Home Manager configuration — multi-platform (Linux / macOS / WSL2)";

  inputs = {
    # x86_64-darwin も評価する入力があるため、Darwin 対応が残る安定版に固定する。
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # home-manager が使う nixpkgs を上の inputs と統一する（重要: 二重取得を防ぐ）
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";

    herdr = {
      url = "github:ogulcancelik/herdr/v0.7.4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hunk = {
      url = "github:modem-dev/hunk/v0.17.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim nightly ソース（ref:master 相当）
    neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, mac-app-util, herdr, hunk, neovim-src, ... }:
    let
      # ---- ヘルパー関数 ----------------------------------------
      # username / homeDirectory を specialArgs 経由でモジュールに渡す。
      # builtins.getEnv は Flake の pure eval モードで空文字になるため使わない。
      mkHomeConfig =
        { system
        , username
        , homeDirectory
        , modules
        }:
        let
          pkgs = import nixpkgs {
            inherit system;
            # neovim-src から neovim-unwrapped をビルドし直す
            overlays = [
              (import ./nix/security-overlay.nix)
              # easyOverlay binds bun2nix's helpers to prev, so this must
              # follow the security overlay to use its patched Bun.
              hunk.inputs.bun2nix.overlays.default
              herdr.overlays.default
              (final: prev: {
                neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (old: {
                  version = "nightly";
                  src     = neovim-src;
                  doCheck = false;
                  doInstallCheck = false;
                  patches = [ ]; # パッチを一切適用しない
                  postInstall = (old.postInstall or "") + ''
                    if [ ! -f "$out/share/applications/nvim.desktop" ]; then
                      mkdir -p "$out/share/applications"
                      cat > "$out/share/applications/nvim.desktop" <<'EOF'
[Desktop Entry]
Name=Neovim
GenericName=Text Editor
Comment=Edit text files
TryExec=nvim
Exec=nvim %F
Terminal=true
Type=Application
Keywords=Text;editor;
Icon=nvim
Categories=Utility;TextEditor;
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
EOF
                    fi
                  '';
                });
              })
              # mise の test suite は Darwin sandbox で hang/fail しやすいため無効化する
              (final: prev: {
                mise = prev.mise.overrideAttrs (old: {
                  doCheck = if prev.stdenv.hostPlatform.isDarwin then false else (old.doCheck or true);
                  checkFlags = (old.checkFlags or [ ])
                    ++ prev.lib.optionals prev.stdenv.hostPlatform.isDarwin [
                      "--skip=oci::layer::tests::preserve_metadata_dir_layer_keeps_special_permission_bits"
                    ];
                });
              })
              (final: prev: {
                # cmux は nixpkgs 26.05 に未収録のため、公式パッケージ定義を
                # 小さくバックポートする。
                cmux = prev.stdenvNoCC.mkDerivation (finalAttrs: {
                  pname = "cmux";
                  version = "0.64.17";

                  __structuredAttrs = true;
                  strictDeps = true;

                  src = prev.fetchurl {
                    url = "https://github.com/manaflow-ai/cmux/releases/download/v${finalAttrs.version}/cmux-macos.dmg";
                    hash = "sha256-LVdt+sjSY/vDOiRX3JIAhSDffM5KMIC7SZsRwbvKliQ=";
                  };

                  unpackCmd = "7zz x -snld -xr'!*:com.apple.*' $curSrc";
                  nativeBuildInputs = [
                    prev._7zz
                    prev.makeBinaryWrapper
                  ];
                  sourceRoot = ".";

                  installPhase = ''
                    runHook preInstall

                    mkdir -p $out/Applications $out/bin
                    cp -R cmux.app $out/Applications/
                    makeBinaryWrapper \
                      "$out/Applications/cmux.app/Contents/MacOS/cmux" \
                      "$out/bin/cmux"

                    runHook postInstall
                  '';

                  dontFixup = true;

                  meta = {
                    description = "Native macOS terminal built on Ghostty, designed for AI coding agents";
                    homepage = "https://cmux.com";
                    license = prev.lib.licenses.gpl3Plus;
                    sourceProvenance = with prev.lib.sourceTypes; [ binaryNativeCode ];
                    mainProgram = "cmux";
                    platforms = prev.lib.platforms.darwin;
                  };
                });
              })
            ];
            config.allowUnfree = true;  # codeql / _1password-cli 等
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # username と homeDirectory をモジュール側で参照できるようにする
          extraSpecialArgs = { inherit username homeDirectory; };
          modules = modules ++ [
            hunk.homeManagerModules.default
            {
              # Hunk's flake imports nixpkgs separately, outside our overlays.
              # Rebuild --compile with the fixed runtime instead of reusing its
              # upstream package with an embedded vulnerable Bun.
              programs.hunk.package = (hunk.packages.${system}.default.override {
                bun = pkgs.bun;
                bun2nix = pkgs.bun2nix;
              });
            }
          ];
        };

    in {
      # ---- プロファイル定義 ----------------------------------------
      # キーは任意の識別文字列。
      # 適用時: home-manager switch --flake .#<プロファイルキー>
      #
      # TODO: 以下を実際の値に変更してください:
      #   username     → whoami の出力
      #   homeDirectory → echo $HOME の出力
      #   プロファイルキー（"..." の部分） → 任意の識別子（慣例: "ユーザー@ホスト名"）
      #
      # 例: hostname -s が "mbp" で whoami が "hiroshi" なら
      #     "hiroshi@mbp" = mkHomeConfig { ... username = "hiroshi"; ... };

      homeConfigurations = {

        # ---- macOS (Apple Silicon: M1/M2/M3) --------------------
        "mac" = mkHomeConfig {
          system        = "aarch64-darwin";
          username      = "hiroshi";
          homeDirectory = "/Users/hiroshi";
          modules       = [
            ./home/common.nix
            mac-app-util.homeManagerModules.default
            ./home/darwin.nix
          ];
        };

        # ---- WSL2 -----------------------------------------------
        "wsl" = mkHomeConfig {
          system        = "x86_64-linux";
          username      = "hiroshi";
          homeDirectory = "/home/hiroshi";
          modules       = [ ./home/common.nix ./home/linux.nix ./home/wsl.nix ];
        };
      };
    };
}
