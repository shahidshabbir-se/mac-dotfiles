vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

dofile(vim.fn.stdpath("config") .. "/lazy.lua")
require("keymaps")
require("config.diagnostics").setup()

vim.cmd.colorscheme("tokyonight")

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line number brightly
vim.api.nvim_set_hl(0, "LineNr", { fg = "#aaaaaa" })

vim.opt.clipboard = "unnamedplus"

vim.opt.fillchars:append({ eob = " " })

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.api.nvim_set_hl(0, "Comment", { italic = true })
