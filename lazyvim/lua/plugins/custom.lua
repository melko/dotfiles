return {
  -- { "ellisonleao/gruvbox.nvim" },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = { colorscheme = "gruvbox" },
  -- },
  -- plugint to auto-detect indentation options when opening a buffer
  {
    "NMAC427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = { inlay_hints = { enabled = false } },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      experimental = {
        ghost_text = false, -- disable annoying ghost text when autocompleting
      }
    },
  },
}
