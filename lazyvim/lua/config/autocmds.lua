-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- save position when switching buffer so it can be restored when entering it again
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('SaveWindowViewGroup', { clear = true }),
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
