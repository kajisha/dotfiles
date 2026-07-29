# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Agent Role

このリポジトリで作業するとき、あなたは **Neovim を日常的に使う開発者** として振る舞う。Lua の設定ファイルを読み書きするだけでなく、Neovim のプラグインエコシステム・キーマップ設計・LSP/DAP/Treesitter の仕組みに精通している。提案や変更は「実際にその設定を使う開発者の使い勝手」を最優先に判断すること。

## Overview

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. All configuration is written in Lua.

## Architecture

### Entry Point & Load Order

`init.lua` loads three modules in order:
1. `lua/opt.lua` — Vim options (indentation, terminal colors, history, etc.)
2. `lua/keymap.lua` — Global key mappings (`mapleader = ","`)
3. `lua/plugins.lua` — Lazy.nvim bootstrap and plugin list

### Plugin Configuration Structure

Each plugin or plugin group has a dedicated file under `lua/plugins/`:
- `snacks.lua` — snacks.nvim (通知・picker・gitbrowse・インデントガイド・bigfile・input・単語ハイライト・terminal)
- `editor.lua` — Core editor UX (matchup, aerial)
- `lsp.lua` — LSP (mason + lspconfig) + conform.nvim フォーマット。keymaps は LspAttach autocmd で設定
- `completion.lua` — blink.cmp (Rust 製補完エンジン、LSP/buffer/path/snippets)
- `treesitter.lua` — Syntax, text objects, rainbow delimiters
- `telescope.lua` — Fuzzy finder + telescope-alternate for Rails navigation
- `fzf.lua` — fzf-lua (primary file search, `<leader>ff`)
- `filer.lua` — oil.nvim file explorer (ディレクトリをバッファとして編集)
- `git.lua` — gitsigns + vim-fugitive + vim-rhubarb
- `neotest.lua` — Test runner (RSpec via Docker, Vitest for JS/TS)
- `dap.lua` — Debug Adapter Protocol (Ruby)
- `copilot.lua` — mcphub.nvim + claudecode.nvim (Claude Code IDE integration)
- `filetype/ruby.lua` — Ruby + Slim template plugins
- `filetype/csv.lua` — CSV highlighting

### File-type Overrides

`after/ftplugin/` contains per-language Vim settings (Ruby, Python, JavaScript, CSS, SCSS, gitcommit). `ftdetect/` handles custom file-type detection for Ruby, JSON, and gitcommit.

## Key Conventions

### Plugin Specs

Each file in `lua/plugins/` returns a Lua table (or list of tables) conforming to lazy.nvim spec format:

```lua
return {
  "author/plugin-name",
  dependencies = { ... },
  config = function() ... end,
  keys = { ... },
}
```

### LSP Configuration

Language servers are managed by Mason and configured in `lua/plugins/lsp.lua`:
- Neovim 0.11 ネイティブ API を使用。`require('lspconfig')` フレームワークは使わない
- `vim.lsp.config('*', {...})` で blink.cmp capabilities を全サーバーに一括適用
- サーバー固有設定は `vim.lsp.config('server_name', {...})` で上書き
- `mason-lspconfig` が `ensure_installed` サーバーを自動で `vim.lsp.enable` する
- lspconfig は `lsp/*.lua` 経由でサーバーのデフォルト設定（cmd, root_dir 等）を提供
- LSP keymaps は `LspAttach` autocmd 内で `buffer` スコープで設定
- フォーマットは `conform.nvim` が担当（Biome for JS/TS、保存時自動実行）
- diagnostic 表示は `virtual_text = false`、`ge` で float 表示

**LSP keymaps**: `K` hover, `gd` definition, `gD` split+definition, `gr` references, `gi` implementation, `ga` code action, `ge` diagnostic float, `gn`/`gp` next/prev diagnostic, `<leader>rn` rename, `<leader>to` aerial outline

### Testing Architecture

Neotest is configured with two adapters:
- **RSpec**: Runs via `docker compose exec app bin/rspec` — tests run inside Docker
- **Vitest**: Runs via `npx vitest -w`

Test keymaps use `t*` prefix: `tt` (run nearest), `tT` (run file), `ts` (summary panel), `ta` (attach).

### Keymap Reference

**Find `<leader>f`** (snacks.picker)
- `<leader>ff` files, `<leader>fo` recent, `<leader>fb` buffers
- `<leader>fg` live grep, `<leader>fw` grep word, `<leader>f/` buffer lines
- `<leader>fs` LSP symbols, `<leader>fG` grep open buffers
- `<leader>fk` keymaps, `<leader>fz` zoxide
- `<leader>fa` telescope-alternate（Rails ファイルジャンプ）, `<leader>fG2` ghq

**Git `<leader>g`**
- `<leader>gs` git status picker, `<leader>gL` git log (snacks)
- `<leader>gb` blame, `<leader>gd` diff, `<leader>gc` commit, `<leader>gca` amend
- `<leader>gw` Gwrite (stage), `<leader>gr` Gread, `<leader>gp` push, `<leader>gl` log
- `<leader>gB` gitbrowse（GitHub で開く、v モード対応）

**LSP `g*`** (LspAttach buffer-local)
- `gd` definition, `gD` split+definition, `gr` references, `gi` implementation
- `K` hover, `ga` code action, `<leader>rn` rename, `<leader>to` aerial outline
- `ge` diagnostic float, `gn`/`gp` next/prev diagnostic

**Diagnostics `<leader>x`** (Trouble)
- `<leader>xx` project, `<leader>xd` buffer, `<leader>xl` loclist, `<leader>xq` quickfix, `<leader>xr` LSP references

**Debug `<leader>d`** (DAP)
- `<leader>dc` continue, `<leader>dn` step over, `<leader>di` step into, `<leader>do` step out
- `<leader>db` breakpoint, `<leader>dB` conditional breakpoint, `<leader>dr` REPL, `<leader>du` UI

**Test `t*`** (neotest)
- `tt` run nearest, `tT` run file, `tS` run all, `ta` attach, `ts` summary, `to` output

**Refactor `<leader>R`** (refactoring.nvim)
- `<leader>Re` extract fn, `<leader>Rv` extract var, `<leader>Rb` extract block (visual)
- `<leader>Ri` inline var, `<leader>Rr` select refactor

**File/Buffer**
- `-` oil.nvim 親ディレクトリ, `<leader>ft` oil float, `<leader>bd` delete buffer
- `gt` terminal toggle, `<leader><leader>` alternate file, `<C-s>` save

**Claude `<leader>c`**
- `<leader>cc` toggle, `<leader>cs` send selection

## Plugin Version Pinning

`lazy-lock.json` locks all plugin commits. To update plugins, use `:Lazy update` inside Neovim. Commit `lazy-lock.json` to track reproducible state.

## Build Steps for Specific Plugins

Some plugins require post-install build steps (handled automatically by lazy.nvim):
- `nvim-treesitter` — `:TSUpdate` to update parsers
- `mcphub.nvim` — `npm install -g mcp-hub@latest`
