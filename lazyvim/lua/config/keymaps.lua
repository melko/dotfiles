-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- type jk to exit insert mode
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "<C-c>", "<esc>")
-- highlights word under cursor with * do not jump on the next occurrence
vim.keymap.set("n", "*", [[:let @/ = '\<'.expand('<cword>').'\>'|set hlsearch<C-M>]])

vim.keymap.set("n", "<leader><left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<leader><right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader><tab><left>", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })
vim.keymap.set("n", "<leader><tab><right>", "<cmd>tabnext<cr>", { desc = "Next Tab" })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")

-- easier way to go into normal mode inside a terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
-- open a floating terminal
vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>Floaterminal<cr>", { desc = "Floating Terminal" })
