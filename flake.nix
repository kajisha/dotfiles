{
  description = "Home Manager configuration — multi-platform (Linux / macOS / WSL2)";

  inputs = {
    # nixpkgs のバージョンを固定。安定性重視なら "nixos-24.11" に変更する。
    nixpkgs.url = "github:nixos/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      # home-manager が使う nixpkgs を上の inputs と統一する（重要: 二重取得を防ぐ）
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim nightly ソース（ref:master 相当）
    neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim-src, ... }:
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
              (final: prev: {
                neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (old: {
                  version = "nightly";
                  src     = neovim-src;
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
              # direnv の test-zsh が macOS sandbox で hang する既知問題回避
              (final: prev: {
                direnv = prev.direnv.overrideAttrs (old: { doCheck = false; });
              })
            ];
            config.allowUnfree = true;  # codeql / _1password-cli 等
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # username と homeDirectory をモジュール側で参照できるようにする
          extraSpecialArgs = { inherit username homeDirectory; };
          modules = modules;
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
        "hiroshi@mac-arm" = mkHomeConfig {
          system        = "aarch64-darwin";
          username      = "hiroshi";
          homeDirectory = "/Users/hiroshi";
          modules       = [ ./home/common.nix ./home/darwin.nix ];
        };

        "h.kajisha@mac-arm" = mkHomeConfig {
          system        = "aarch64-darwin";
          username      = "h.kajisha";
          homeDirectory = "/Users/h.kajisha";
          modules       = [ ./home/common.nix ./home/darwin.nix ];
        };

        # home-manager switch --flake . でプロファイルキー省略時に解決されるエイリアス
        "h.kajisha" = mkHomeConfig {
          system        = "aarch64-darwin";
          username      = "h.kajisha";
          homeDirectory = "/Users/h.kajisha";
          modules       = [ ./home/common.nix ./home/darwin.nix ];
        };

        # ---- macOS (Intel) ---------------------------------------
        "hiroshi@mac-intel" = mkHomeConfig {
          system        = "x86_64-darwin";
          username      = "hiroshi";
          homeDirectory = "/Users/hiroshi";
          modules       = [ ./home/common.nix ./home/darwin.nix ];
        };

        # ---- Linux (non-NixOS, x86_64) --------------------------
        "hiroshi@linux" = mkHomeConfig {
          system        = "x86_64-linux";
          username      = "hiroshi";
          homeDirectory = "/home/hiroshi";
          modules       = [ ./home/common.nix ./home/linux.nix ];
        };

        # ---- WSL2 -----------------------------------------------
        "hiroshi@Desktop" = mkHomeConfig {
          system        = "x86_64-linux";
          username      = "hiroshi";
          homeDirectory = "/home/hiroshi";
          modules       = [ ./home/common.nix ./home/linux.nix ./home/wsl.nix ];
        };
      };
    };
}
