-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

-- Command Mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Select All
map("n", "<C-a>", "ggVG$", { desc = "Select all in NORMAL mode" })
map("v", "<C-a>", "<Esc>ggVG$", { desc = "Select all in VISUAL mode" })
map("i", "<C-a>", "<Esc>ggVG$", { desc = "Select all in INSERT mode" })

-- -- Sessions
-- map("n", "<leader>ss", "<cmd>SessionSearch<CR>", { noremap = true, silent = true, desc = "Search session" })
-- map("n", "<leader>sr", ":SessionRestore<CR>", { noremap = true, silent = true, desc = "Restore session" })
