# Home Manager 設定

このリポジトリは、Nix を使用した Home Manager の設定を管理しています。

## 例: neovim-src からビルドする方法

現在の設定では、`neovim-nightly`のビルドエラーを解消するために `neovim-src` からビルドするように設定されています。

### 1. home-manager switch によるビルド（通常の方法）

```bash
home-manager switch --flake .#h.kajisha@mac-arm
```

> ⚠️ 注意: このコマンドは`neovim-nightly`のビルド処理が非常に時間がかかる場合、`timeout`で中断される可能性があります。

### 2. nix build による代替方法（時間のかかるビルドの回避）

```bash
nix build .#homeConfigurations."h.kajisha@mac-arm".activationPackage
nix profile install --profile ~/.nix-profile ./result
```

この方法で、`home-manager` によるビルドを回避し、`neovim-src` から直接ビルドを行えます。

### 3. ビルド完了後の確認

```bash
which nvim
nvim --version
```

上記コマンドで、`nvim`が正しくインストールされており、`neovim-src` からビルドされたことが確認できます。

## 4. neovim-nightly の削除

設定では `neovim-nightly` パッケージは削除されており、`neovim-unwrapped` が `neovim-src` からビルドされるように設定されています。