-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.winbar = "%=%m %f"
vim.opt.mouse = "nv"
vim.opt.relativenumber = false
--vim.opt.shiftwidth = 4
--vim.opt.tabstop = 4
vim.opt.spelllang = { "en", "it" }
vim.opt.wrap = true
vim.g.autoformat = false -- disable annoying autoformat on save
vim.g.root_spec = { "lsp", { ".git", "lua", ".svn", ".hg", ".bzr", "_darcs", "Makefile", ".idea", ".project" }, "cwd" }
