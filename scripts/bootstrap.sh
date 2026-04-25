#!/usr/bin/env bash
# bootstrap.sh — Nix インストール + home-manager 初回セットアップ
# 使い方: bash scripts/bootstrap.sh
set -euo pipefail

# ---- カラー出力 -----------------------------------------------
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${BLUE}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}[OK]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; exit 1; }

# ---- 環境判定 -------------------------------------------------
detect_platform() {
  local os; os="$(uname -s)"
  case "$os" in
    Darwin) echo "darwin" ;;
    Linux)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
      else
        echo "linux"
      fi
      ;;
    *) error "未対応のOS: $os" ;;
  esac
}

PLATFORM=$(detect_platform)
USER_NAME="${USER:-$(whoami)}"
HOST_NAME="$(hostname -s)"

info "プラットフォーム: $PLATFORM"
info "ユーザー: $USER_NAME"
info "ホスト: $HOST_NAME"
echo ""

# ---- Step 1: Nix のインストール確認 ---------------------------
echo -e "${BOLD}Step 1: Nix の確認${RESET}"
if command -v nix &>/dev/null; then
  success "Nix はすでにインストールされています: $(nix --version)"
else
  warn "Nix が見つかりません。Determinate Nix インストーラーを実行します..."
  echo ""
  echo "以下のコマンドを手動で実行してください:"
  echo ""
  echo "  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install"
  echo ""
  echo "インストール後、シェルを再起動してからこのスクリプトを再実行してください。"
  exit 1
fi

# ---- Step 2: Flakes の有効確認 --------------------------------
echo ""
echo -e "${BOLD}Step 2: Flakes の確認${RESET}"
if nix show-config 2>/dev/null | grep -q "experimental-features.*flakes"; then
  success "Flakes は有効です"
else
  warn "Flakes が有効でない可能性があります"
  info "Determinate Nix を使っている場合は自動で有効なはずです"
fi

# ---- Step 3: プロファイル名の決定 -----------------------------
echo ""
echo -e "${BOLD}Step 3: home-manager プロファイルの選択${RESET}"
echo ""
echo "利用可能なプロファイル (flake.nix で定義):"
echo "  1) ${USER_NAME}@linux    — Linux (non-NixOS)"
echo "  2) ${USER_NAME}@wsl      — WSL2"
echo "  3) ${USER_NAME}@mac-arm  — macOS (Apple Silicon)"
echo "  4) ${USER_NAME}@mac-intel — macOS (Intel)"
echo "  5) カスタム入力"
echo ""
echo -n "番号を選択してください [1-5]: "
read -r choice

case "$choice" in
  1) PROFILE="${USER_NAME}@linux" ;;
  2) PROFILE="${USER_NAME}@wsl" ;;
  3) PROFILE="${USER_NAME}@mac-arm" ;;
  4) PROFILE="${USER_NAME}@mac-intel" ;;
  5)
    echo -n "プロファイル名を入力 (例: ${USER_NAME}@${HOST_NAME}): "
    read -r PROFILE
    ;;
  *) error "無効な選択です" ;;
esac

info "選択されたプロファイル: $PROFILE"

# ---- Step 4: flake.nix のプレースホルダー確認 -----------------
echo ""
echo -e "${BOLD}Step 4: 設定ファイルの確認${RESET}"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
info "dotfiles ディレクトリ: $DOTFILES_DIR"

if grep -r "CHANGEME_" "$DOTFILES_DIR/flake.nix" "$DOTFILES_DIR/home/" &>/dev/null; then
  warn "以下のファイルにプレースホルダーが残っています:"
  grep -rl "CHANGEME_" "$DOTFILES_DIR/flake.nix" "$DOTFILES_DIR/home/" | sed 's/^/  /'
  echo ""
  echo "home-manager switch を実行する前に、これらを実際の値に置き換えてください。"
  echo ""
  echo -n "続行しますか？ [y/N]: "
  read -r proceed
  [[ "$proceed" =~ ^[Yy]$ ]] || exit 0
fi

# ---- Step 5: home-manager switch ------------------------------
echo ""
echo -e "${BOLD}Step 5: home-manager switch${RESET}"
info "実行コマンド: home-manager switch --flake \"${DOTFILES_DIR}#${PROFILE}\""
echo ""
echo -n "実行しますか？ [y/N]: "
read -r run_switch
if [[ "$run_switch" =~ ^[Yy]$ ]]; then
  cd "$DOTFILES_DIR"
  home-manager switch --flake ".#${PROFILE}"
  success "home-manager switch が完了しました！"
else
  info "後で手動で実行してください:"
  echo "  cd $DOTFILES_DIR"
  echo "  home-manager switch --flake .#${PROFILE}"
fi

echo ""
success "ブートストラップ完了 🎉"
