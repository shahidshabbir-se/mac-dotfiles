local map = vim.keymap.set

require("keymaps.nvimtree")
require("keymaps.windows")
require("keymaps.indent-blankline")
require("keymaps.bufferline")

map("n", "<C-a>", "ggVG$", { desc = "Select all in NORMAL mode" })
map("v", "<C-a>", "<Esc>ggVG$", { desc = "Select all in VISUAL mode" })
map("i", "<C-a>", "<Esc>ggVG$", { desc = "Select all in INSERT mode" })
map("n", ";", ":", { desc = "CMD enter command mode" })
