# dotfiles — home-manager 構成

Nix Flakes + standalone home-manager によるマルチプラットフォーム dotfile 管理。

対応プラットフォーム: **macOS** / **Linux (non-NixOS)** / **WSL2**

---

## クイックスタート

### 1. Nix のインストール

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

インストール後、シェルを再起動する。

### 2. このリポジトリをクローン

```bash
git clone git@github.com:kajisha/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. ブートストラップを実行

```bash
bash scripts/bootstrap.sh
```

スクリプトがプラットフォームを検出し、適切なプロファイルで `home-manager switch` を実行する。

---

## ファイル構造

```
dotfiles/
├── flake.nix               # エントリポイント。プロファイルを定義
├── flake.lock              # バージョンロック（git 管理必須）
├── home/
│   ├── common.nix          # 全 OS 共通（modules をインポート）
│   ├── linux.nix           # Linux (non-NixOS) 固有
│   ├── darwin.nix          # macOS 固有
│   ├── wsl.nix             # WSL2 追加設定
│   └── modules/
│       ├── shell.nix       # zsh / fish / direnv / fzf
│       ├── git.nix         # git / gh / delta
│       ├── editor.nix      # neovim
│       └── apps.nix        # パッケージ / starship / tmux / bat / eza
├── scripts/
│   ├── bootstrap.sh        # 初回セットアップ
│   └── migrate.sh          # chezmoi からの移行支援
└── README.md
```

---

## プロファイル一覧

| プロファイル | 対象 OS | アーキテクチャ |
|-------------|---------|--------------|
| `YOUR_USER@mac-arm` | macOS (M1/M2/M3) | aarch64-darwin |
| `YOUR_USER@mac-intel` | macOS (Intel) | x86_64-darwin |
| `YOUR_USER@linux` | Linux (non-NixOS) | x86_64-linux |
| `YOUR_USER@wsl` | WSL2 | x86_64-linux |

> **TODO**: `flake.nix` と `home/common.nix` の `YOUR_USER` を実際のユーザー名に変更する。

---

## 日常的な操作

### 設定を適用する

```bash
home-manager switch --flake ~/dotfiles#YOUR_USER@HOSTNAME
```

### パッケージを追加する

`home/modules/apps.nix` の `home.packages` にパッケージ名を追加して再度 switch する。

```nix
home.packages = with pkgs; [
  ripgrep
  neofetch   # ← 追加
];
```

### nixpkgs を最新化する

```bash
cd ~/dotfiles
nix flake update          # flake.lock を更新
home-manager switch --flake .#YOUR_USER@HOSTNAME
```

### 前の世代にロールバックする

```bash
home-manager generations               # 世代一覧を表示
home-manager switch --generation 42   # 42 番の世代に戻す
```

### 古い世代を削除してディスク容量を確保する

```bash
home-manager expire-generations "-30 days"  # 30日以上前を削除
nix store gc                                 # Nix ストアを掃除
```

---

## chezmoi からの移行

```bash
bash scripts/migrate.sh
```

---

## よく使うリソース

- [home-manager オプション検索](https://mipmip.github.io/home-manager-option-search/) — `programs.zsh` などを検索
- [NixOS パッケージ検索](https://search.nixos.org/packages) — パッケージ名を検索
- [home-manager 公式マニュアル](https://nix-community.github.io/home-manager/)
- [Zero to Nix](https://zero-to-nix.com/) — Nix 入門ガイド

---

## トラブルシューティング

### `error: flake 'path:...' does not provide attribute`

プロファイル名が `flake.nix` の `homeConfigurations` キーと一致していない。  
`whoami` と `hostname -s` でユーザー名・ホスト名を確認し、`flake.nix` を修正する。

### WSL2 でサービスが起動しない

WSL2 の systemd が無効の可能性がある。`/etc/wsl.conf` に以下を追加して WSL を再起動:

```ini
[boot]
systemd=true
```

または `home/wsl.nix` で該当サービスを `enable = false` にする。

### macOS でコマンドが見つからない

`~/.nix-profile/bin` が PATH に入っているか確認する:

```bash
echo $PATH | tr ':' '\n' | grep nix
```

入っていない場合、シェルの設定ファイルに `source ~/.nix-profile/etc/profile.d/hm-session-vars.sh` を追加する。
