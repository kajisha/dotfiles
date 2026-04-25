{
  description = "Home Manager configuration — multi-platform (Linux / macOS / WSL2)";

  inputs = {
    # nixpkgs のバージョンを固定。安定性重視なら "nixos-24.11" に変更する。
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      # home-manager が使う nixpkgs を上の inputs と統一する（重要: 二重取得を防ぐ）
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim nightly ビルド（ref:master 相当）
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay, ... }:
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
            # neovim nightly overlay: pkgs.neovim を nightly ビルドに差し替える
            overlays = [ neovim-nightly-overlay.overlays.default ];
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
