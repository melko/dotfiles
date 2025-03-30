-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.winbar = "%=%m %f"
vim.opt.mouse = "nv"
--vim.opt.relativenumber = false
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.spelllang = { "en", "it" }
vim.opt.wrap = true
vim.opt.clipboard = ""
vim.opt.conceallevel = 0
vim.opt.ignorecase = false

-- default to vertical spit for diffs
vim.opt.diffopt:append("vertical")

vim.g.autoformat = false -- disable annoying autoformat on save
vim.g.root_spec = { ".project", "lsp", { ".git", "lua", ".svn", ".hg", ".bzr", "_darcs", "Makefile", ".idea" }, "cwd" }

-- fully opaque completion window
vim.o.pumblend = 0

-- '-' is misleading for trailing spaces (can be confused with comments for some languages)
vim.opt.listchars = { tab = "»_", trail = "~" }

-- disable all animations
vim.g.snacks_animate = false

-- disable AI completion (also remove ghost text)
vim.g.ai_cmp = false
