-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- type jk to exit insert mode
vim.keymap.set("i", "jk", "<esc>")
-- highlights word under cursor with * do not jump on the next occurrence
vim.keymap.set("n", "*", [[:let @/ = '\<'.expand('<cword>').'\>'|set hlsearch<C-M>]])