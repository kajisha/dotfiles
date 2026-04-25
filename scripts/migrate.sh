#!/usr/bin/env bash
# migrate.sh — chezmoi から home-manager への移行支援スクリプト
# 使い方: bash scripts/migrate.sh
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${BLUE}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}[OK]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; exit 1; }

echo -e "${BOLD}chezmoi → home-manager 移行スクリプト${RESET}"
echo "============================================"
echo ""

# ---- Step 1: chezmoi の確認 -----------------------------------
echo -e "${BOLD}Step 1: chezmoi の管理ファイル確認${RESET}"
if ! command -v chezmoi &>/dev/null; then
  warn "chezmoi が見つかりません。すでにアンインストール済みか、PATH にないかもしれません。"
else
  info "chezmoi で管理されているファイル:"
  chezmoi managed 2>/dev/null | head -50 || true
  echo ""
  MANAGED_COUNT=$(chezmoi managed 2>/dev/null | wc -l || echo "不明")
  info "合計: ${MANAGED_COUNT} ファイル"
fi

# ---- Step 2: バックアップ -------------------------------------
echo ""
echo -e "${BOLD}Step 2: chezmoi ソースのバックアップ${RESET}"
BACKUP_FILE="$HOME/chezmoi-backup-$(date +%Y%m%d-%H%M%S).tar.gz"

if command -v chezmoi &>/dev/null; then
  info "バックアップを作成しています: $BACKUP_FILE"
  chezmoi archive --output "$BACKUP_FILE" 2>/dev/null && \
    success "バックアップ完了: $BACKUP_FILE" || \
    warn "バックアップに失敗しました（続行します）"
else
  warn "chezmoi が見つからないためバックアップをスキップします"
fi

# ---- Step 3: 移行チェックリスト表示 ---------------------------
echo ""
echo -e "${BOLD}Step 3: 移行チェックリスト${RESET}"
echo ""
echo "home-manager の設定が完了しているか確認してください:"
echo ""

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

check_placeholder() {
  local file="$1"
  local label="$2"
  if [ -f "$file" ] && grep -q "YOUR_USER\|YOUR_NAME\|YOUR_EMAIL\|TODO" "$file" 2>/dev/null; then
    echo -e "  ${YELLOW}[ ]${RESET} $label — プレースホルダーあり: $file"
  else
    echo -e "  ${GREEN}[✓]${RESET} $label"
  fi
}

check_placeholder "$DOTFILES_DIR/home/common.nix"       "common.nix (ユーザー名・ホームディレクトリ)"
check_placeholder "$DOTFILES_DIR/home/modules/git.nix"  "git.nix (名前・メールアドレス)"
check_placeholder "$DOTFILES_DIR/flake.nix"             "flake.nix (プロファイル名)"

echo ""
echo "  移植が必要な設定:"
echo "  [ ] shell 設定 (zshrc/config.fish の内容 → modules/shell.nix)"
echo "  [ ] git エイリアス (→ modules/git.nix)"
echo "  [ ] neovim 設定 (init.lua/vimrc → modules/editor.nix)"
echo "  [ ] アプリ設定 (starship.toml, .tmux.conf → modules/apps.nix)"
echo "  [ ] SSH 設定 (~/.ssh/config → modules/apps.nix の programs.ssh)"

# ---- Step 4: home-manager switch テスト -----------------------
echo ""
echo -e "${BOLD}Step 4: home-manager switch のドライラン${RESET}"
if ! command -v home-manager &>/dev/null; then
  warn "home-manager が見つかりません。bootstrap.sh を先に実行してください。"
else
  info "ドライランでエラーを確認します..."
  echo -n "プロファイル名を入力してください (例: $(whoami)@wsl): "
  read -r PROFILE

  cd "$DOTFILES_DIR"
  info "実行: home-manager build --flake .#${PROFILE}"
  if home-manager build --flake ".#${PROFILE}" 2>&1; then
    success "ビルド成功！home-manager switch を実行できます。"
    echo ""
    echo "  home-manager switch --flake .#${PROFILE}"
  else
    error "ビルドに失敗しました。エラーメッセージを確認して設定を修正してください。"
  fi
fi

# ---- Step 5: chezmoi のアンインストール案内 -------------------
echo ""
echo -e "${BOLD}Step 5: chezmoi のアンインストール（home-manager が正常動作した後に実施）${RESET}"
echo ""
echo "  # 1. chezmoi が管理するファイル（シンボリックリンク等）を削除"
echo "  chezmoi purge"
echo ""
echo "  # 2. chezmoi バイナリを削除"
CHEZMOI_BIN=$(command -v chezmoi 2>/dev/null || echo "~/.local/bin/chezmoi")
echo "  rm $CHEZMOI_BIN"
echo ""
echo "  # 3. chezmoi ソースディレクトリを削除（バックアップを確認してから）"
CHEZMOI_SRC=$(chezmoi source-path 2>/dev/null || echo "~/.local/share/chezmoi")
echo "  rm -rf $CHEZMOI_SRC"
echo ""
warn "アンインストールは home-manager で全設定が正常に動作してから行ってください！"

echo ""
success "移行スクリプト完了"
