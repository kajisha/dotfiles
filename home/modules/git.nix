# modules/git.nix — Git 設定
{ ... }:

{
  # programs.git.settings は home-manager master で導入された新しい形式
  programs.git = {
    enable = true;

    # ---- エイリアス -------------------------------------------
    settings = {
      user = {
        name  = "Hiroshi Kajisha";
        email = "kajisha@gmail.com";
      };

      alias = {
        st  = "status -sb";
        co  = "checkout";
        sw  = "switch";
        br  = "branch";
        lg  = "log --oneline --graph --decorate --all";
        pu  = "push";
        pl  = "pull --rebase";
        aa  = "add --all";
        cm  = "commit -m";
        amend   = "commit --amend --no-edit";
        unstage = "reset HEAD --";
        last    = "log -1 HEAD";
      };

      core = {
        editor    = "nvim";
        autocrlf  = "input";
        whitespace = "trailing-space,space-before-tab";
      };

      pull.rebase           = true;
      push.autoSetupRemote  = true;
      init.defaultBranch    = "main";
      merge.conflictstyle   = "zdiff3";
      diff.algorithm        = "histogram";
      rebase.autosquash     = true;
      rebase.autostash      = true;
    };

    ignores = [
      ".DS_Store" ".DS_Store?" "Thumbs.db" "desktop.ini"
      "*.swp" "*.swo" ".idea/" ".vscode/" "*.code-workspace"
      ".direnv/" ".envrc" "*.env" ".env.local"
      "node_modules/" "__pycache__/" "*.pyc" ".pytest_cache/"
    ];
  };

  # ---- delta (diff ハイライター) --------------------------------
  # home-manager master では programs.delta に分離された
  programs.delta = {
    enable                = true;
    enableGitIntegration  = true;  # 明示的に設定（deprecation 回避）
    options = {
      navigate     = true;
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "Dracula";
    };
  };

  # ---- GitHub CLI ----------------------------------------------
  programs.gh = {
    enable   = true;
    settings = {
      git_protocol = "ssh";
      editor       = "nvim";
    };
  };
}
