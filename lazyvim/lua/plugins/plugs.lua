-- This file contains non-default plugins

return {
  -- plugin to auto-detect indentation options when opening a buffer
  {
    "NMAC427/guess-indent.nvim",
    opts = {},
  },

  {
    "diffview.nvim",
    cmd = "DiffviewOpen",
  },

  -- magit but for neovim
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    opts = { graph_style = "unicode" },
    cmd = "Neogit",
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },
}
