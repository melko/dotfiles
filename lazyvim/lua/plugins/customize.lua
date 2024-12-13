-- This file contains customization to default plugins

return {
  -- { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
    optional = true,
    opts = { colorscheme = "tokyonight-night" },
  },

  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = {
      options = {
        numbers = "buffer_id", -- display buffer numbers on the bufferline
        separator_style = "slant",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    -- disable inlay hints (function argument name showing) since they visually clutter everything
    opts = { inlay_hints = { enabled = false } },
  },

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      local cmp = require("cmp")

      -- do not preselect first entry (add noselect to default config)
      opts.completion = { completeopt = "menu,menuone,noinsert,noselect" }

      opts.experimental = {
        ghost_text = false, -- disable annoying ghost text when autocompleting
      }

      -- add borders to completion window
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
        ["<CR>"] = LazyVim.cmp.confirm({ select = false }), -- do not complete with <CR> when nothing is selected
        ["<C-j>"] = LazyVim.cmp.confirm({ select = true }), -- use C-j to complete first entry when nothing is selected
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
    optional = true,
    opts = function(_, opts)
      local logo = [[
⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡴⠖⠒⠶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈
⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⢀⡰⠋⠀⢸⡆⠀⠈⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⠶⠛⠡⣏⠡⡀⢷⣄⡀⠀⠈⠙⠶⡄⠀⠤⠘⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠁⠀⠀⠀⠀⠙⠦⣈⠚⢹⡷⠤⠿⢷⣄⢹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⢏⠐⠀⠀⠀⣀⣀⣀⡀⢈⠹⡏⠁⠀⠀⠀⠘⢧⣻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⡋⠁⠀⠀⠀⢰⣮⡭⠭⠤⢄⡀⢣⣷⠀⠀⠀⠀⠀⠀⠍⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⠶⣾⣆⡀⠀⠀⣀⡴⠟⠁⣠⣾⣤⣄⡙⢖⢿⡆⠀⠀⠀⠀⠀⠀⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠰⠀⠀⠀⠀⠂⠀⢀⢰⣯⣦⡀⠈⠳⢄⡴⠋⠉⢀⣴⣿⣿⣿⣿⣿⣧⡘⠜⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠆⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠈⠻⡿⣿⣆⠀⢸⡇⢀⣴⣿⣿⣿⣿⣿⣿⣿⣃⡅⢰⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⢻⣿⡿⡷⠼⠳⠞⠻⠿⣿⠯⠭⠿⠿⠫⠅⢁⠈⠳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⣄⡤⠈⠁⠀⢀⡀⡀⣀⠈⠉⢆⠀⠠⠤⠄⣈⡀⡀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⢀⡞⣩⣶⣶⣶⣶⣿⣿⣿⣿⣿⣶⣶⣶⠶⠿⠛⠲⢯⣙⣿⣆⣀⡀⠀⠀⠈⠀⠀⠄⠀⠀⠀⠀⠀⠂
⠀⠀⠀⠀⢸⢳⡄⠀⠀⠀⠀⠀⢀⣨⡿⠸⡿⣿⣿⣿⣿⡿⠿⡟⠋⢉⣡⠤⠀⠀⠀⠀⢉⡩⠝⣛⣉⣭⣭⣽⣶⣷⣤⡀⠀⢀⠀⠀⠀⠀
⠀⠀⠀⠀⠈⢣⡹⢶⣲⡶⣤⣠⡼⢏⢀⡠⣶⡶⠿⢍⣀⣀⣉⡠⠖⠋⠉⠁⢀⠀⢐⣨⠵⠖⠋⠉⠀⠀⠀⠀⠀⠉⠙⢿⣆⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣙⢮⣳⢿⣌⠊⠁⡸⠅⠀⠀⠉⠐⠂⠔⢺⠉⠀⠀⠠⢔⣈⡵⠾⠛⠓⠒⠦⢄⠀⠀⠀⠀⠀⠀⠀⢀⣨⠞⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠈⠈⠀⠶⠉⠳⣝⠳⠦⣤⡄⡀⠀⠀⢀⠀⠀⠀⠃⣀⣤⣖⣉⣁⣀⣀⣀⣄⠤⠤⠶⠶⠶⠤⠤⠴⠶⠒⠉⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠱⠀⠀⠀⡈⠓⠦⠤⣀⣩⣍⣉⣭⠤⠶⠒⠋⡙⠀⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ]]
      --logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.dashboard.preset.header = logo
    end,
  },

  {
    "gitsigns.nvim",
    optional = true,
    keys = {
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this" },
    },
  },
}
