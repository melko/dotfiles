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
vim.opt.clipboard = "unnamed"
vim.opt.conceallevel = 0

-- default to vertical spit for diffs
vim.opt.diffopt:append("vertical")

vim.g.autoformat = false -- disable annoying autoformat on save
vim.g.root_spec = { "lsp", { ".git", "lua", ".svn", ".hg", ".bzr", "_darcs", "Makefile", ".idea", ".project" }, "cwd" }

-- fully opaque completion window
vim.o.pumblend = 0

-- '-' is misleading for trailing spaces (can be confused with comments for some languages)
vim.opt.listchars = { tab = "»»", trail = "~" }

-- save position when switching buffer so it can be restored when entering it again
vim.api.nvim_create_augroup('SaveWindowViewGroup', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = 'SaveWindowViewGroup',
  pattern = '*',
  callback = function ()
    if vim.b.winview
    then vim.fn.winrestview(vim.b.winview)
    end
    --else vim.b.winview = nil end
  end,
})
vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  group = 'SaveWindowViewGroup',
  pattern = '*',
  callback = function () vim.b.winview = vim.fn.winsaveview() end,
})
