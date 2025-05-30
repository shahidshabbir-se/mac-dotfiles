-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd([[colorscheme tokyonight-moon]])
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none", fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none", fg = "#888888", bold = true })
