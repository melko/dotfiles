-- This file contains non-default plugins

return {
  -- plugin to auto-detect indentation options when opening a buffer
  {
    "NMAC427/guess-indent.nvim",
    opts = {},
  },

  {
    "diffview.nvim",
    optional = true,
    cmd = "DiffviewOpen",
  },

  -- magit but for neovim
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      --"nvim-telescope/telescope.nvim", -- optional
      --"ibhagwan/fzf-lua",              -- optional
      --"echasnovski/mini.pick",         -- optional
      "folke/snacks.nvim",             -- optional
    },
    opts = { graph_style = "unicode" },
    cmd = "Neogit",
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },

  -- Improved UI and workflow for the Neovim quickfix
  {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    opts = {},
  }
}
