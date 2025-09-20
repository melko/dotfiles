-- This file contains customization to default plugins

return {
  -- { "ellisonleao/gruvbox.nvim" },
  {
    "folke/tokyonight.nvim",
    optional = true,
    opts = {
      styles = {
        keywords = { italic = true, bold = true },
        functions = { bold = true },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    optional = true,
    opts = { colorscheme = "tokyonight-moon" },
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
    "folke/noice.nvim",
    optional = true,
    opts = { presets = { lsp_doc_border = true } },
  },

  {
    "nvim-mini/mini.pairs",
    optional = true,
    opts = {
      modes = { command = false }, -- autopair in command mode should be banned
      mappings = {
        -- attempt to get a better behavior
        -- inspiration from https://gist.github.com/tmerse/dc21ec932860013e56882f23ee9ad8d2
        ["["] = { action = "open", pair = "[]", neigh_pattern = ".[%s%z%)}%]]" },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = ".[%s%z%)}%]]", },
        ["("] = { action = "open", pair = "()", neigh_pattern = ".[%s%z%)]", },
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = '[^%w\\"][^%w]', register = { cr = true }, },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%w\\'][^%w]", register = { cr = true }, },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%w\\`][^%w]", register = { cr = true }, },
      }
    },
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    -- disable inlay hints (function argument name showing) since they visually clutter everything
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,
        virtual_lines = { current_line = true },
      },
      servers = {
        tinymist = {
          mason = false, -- do not autoinstall with mason
          root_dir = function(_)
            return LazyVim.root.get()
          end,
        },
      },
    },
    -- opts = function(_, opts)
    --   require("lspconfig").pyright.setup {}
    --   opts.inlay_hints = { enabled = false },
    -- end,
  },

  {
    "Saghen/blink.cmp",
    optional = true,
    opts = {
      completion = {
        menu = {
          border = "rounded",
          draw = {
            -- make completion window similar to nvim-cmp
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },

        documentation = { window = { border = "rounded", }, },
      },

      keymap = {
        preset = "super-tab",
        -- restore preset behavior since LazyVim overrides some stuff
        ["<C-y>"] = {},
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      local cmp = require("cmp")

      -- do not preselect first entry (add noselect to default config)
      opts.completion = { completeopt = "menu,menuone,noinsert,noselect" }

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
