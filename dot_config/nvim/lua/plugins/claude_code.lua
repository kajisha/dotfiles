return {
  -- {
  --   "coder/claudecode.nvim",
  --   dependencies = { "folke/snacks.nvim" },
  --   config = true,
  --   keys = {
  --     { "<leader>c", nil, desc = "AI/Claude Code" },
  --     { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
  --     { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
  --     { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
  --     { "<leader>ccc", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
  --     { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
  --     { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
  --     { "<leader>ac", "<cmd>ClaudeCodeAdd %<cr>", mode = "v", desc = "Add current buffer" },
  --
  --     {
  --       "<leader>as",
  --       "<cmd>ClaudeCodeTreeAdd<cr>",
  --       desc = "Add file",
  --       ft = { "NvimTree", "neo-tree", "oil" },
  --     },
  --     -- Diff management
  --     { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
  --     { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  --   },
  -- },

  {
    "Piotr1215/pairup.nvim",
    cmd = { "Pairup" },
    keys = {
      { "<leader>cc", "<cmd>Pairup start<cr>", desc = "Start Claude" },
      { "<leader>ct", "<cmd>Pairup toggle<cr>", desc = "Toggle terminal" },
      { "<leader>cq", "<cmd>Pairup questions<cr>", desc = "Show questions" },
      { "<leader>cx", "<cmd>Pairup stop<cr>", desc = "Stop Claude" },
    },
    config = function()
      require("pairup").setup()
      -- Default works out of the box. Override only if needed:
      -- require("pairup").setup({
      --   providers = {
      --     claude = { cmd = "claude --permission-mode plan" },
      --   },
      -- })
    end,
  },
}
