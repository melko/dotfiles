-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- save position when switching buffer so it can be restored when entering it again
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("SaveWindowViewGroup", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.b.winview then
      vim.fn.winrestview(vim.b.winview)
    end
    --else vim.b.winview = nil end
  end,
})
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  group = "SaveWindowViewGroup",
  pattern = "*",
  callback = function()
    vim.b.winview = vim.fn.winsaveview()
  end,
})

-- switch to absolute row numbers in insert mode
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("ToggleRelativeNum", { clear = true }),
  callback = function()
    if vim.o.number then
      vim.opt.relativenumber = false
      vim.cmd("redraw")
    end
  end,
})

-- switch back to relative numbers when leaving insert mode
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = "ToggleRelativeNum",
  callback = function()
    if vim.o.number and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt_local.relativenumber = true
      vim.cmd("redraw")
    end
  end,
})

-- yankring
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup("yankring", { clear = true}),
  callback = function()
    if vim.v.event.operator == 'y' then
      for i = 9, 1, -1 do -- Shift all numbered registers.
        vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
      end
    end
  end,
})
