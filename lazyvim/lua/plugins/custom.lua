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
    -- disable inlay hints (function argument name showing) since they visually clutter everything
    opts = { inlay_hints = { enabled = false } },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.experimental = {
        ghost_text = false, -- disable annoying ghost text when autocompleting
      }
      -- overwrite default mapping to remove <C-y>
      opts.mapping = cmp.mapping({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = LazyVim.cmp.confirm({ select = true }),
        ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local logo = [[
  ██████  ██▓ ██▓    ▓█████  ███▄    █  ▄████▄  ▓█████ 
▒██    ▒ ▓██▒▓██▒    ▓█   ▀  ██ ▀█   █ ▒██▀ ▀█  ▓█   ▀ 
░ ▓██▄   ▒██▒▒██░    ▒███   ▓██  ▀█ ██▒▒▓█    ▄ ▒███   
  ▒   ██▒░██░▒██░    ▒▓█  ▄ ▓██▒  ▐▌██▒▒▓▓▄ ▄██▒▒▓█  ▄ 
▒██████▒▒░██░░██████▒░▒████▒▒██░   ▓██░▒ ▓███▀ ░░▒████▒
▒ ▒▓▒ ▒ ░░▓  ░ ▒░▓  ░░░ ▒░ ░░ ▒░   ▒ ▒ ░ ░▒ ▒  ░░░ ▒░ ░
░ ░▒  ░ ░ ▒ ░░ ░ ▒  ░ ░ ░  ░░ ░░   ░ ▒░  ░  ▒    ░ ░  ░
░  ░  ░   ▒ ░  ░ ░      ░      ░   ░ ░ ░           ░   
      ░   ░      ░  ░   ░  ░         ░ ░ ░         ░  ░
                                       ░               
      ]]
      --logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.dashboard.preset.header = logo
    end,
  },
}
