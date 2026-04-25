# modules/editor.nix — エディタ設定（Neovim）
{ pkgs, ... }:

{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    vimAlias      = true;
    viAlias       = true;
    withPython3   = false;  # 新デフォルト（警告回避）

    extraPackages = with pkgs; [
      ripgrep
      fd
    ];

    plugins = with pkgs.vimPlugins; [
      # TODO: 使っているプラグインを列挙
    ];

    # home-manager master では initLua に改名された
    initLua = ''
      vim.opt.number         = true
      vim.opt.relativenumber = true
      vim.opt.expandtab      = true
      vim.opt.tabstop        = 2
      vim.opt.shiftwidth     = 2
      vim.opt.smartindent    = true
      vim.opt.wrap           = false
      vim.opt.termguicolors  = true
      vim.opt.mouse          = "a"
      vim.opt.clipboard      = "unnamedplus"
      vim.opt.ignorecase     = true
      vim.opt.smartcase      = true
      vim.opt.splitbelow     = true
      vim.opt.splitright     = true

      vim.g.mapleader = " "

      -- TODO: 既存の init.lua の設定をここに移植してください
    '';
  };
}
