local dashboard = require("dashboard")

dashboard.setup({
  theme = 'hyper',          -- 'doom' or 'hyper'
  disable_move = false,
  shortcut_type = 'letter', -- 'letter' or 'number'
  shuffle = false,          -- Shuffle letters if type is 'letter'
  shortcut = {
    -- Optional: manually define letter_list (default is a-z excluding j and k)
    letter_list = nil,
  },
  change_to_vcs_root = false,

  config = {
    header = {
      "   ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
      "   ████╗  ██║██║   ██║██║████╗ ████║",
      "   ██╔██╗ ██║██║   ██║██║██╔████╔██║",
      "   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    },
    -- Add shortcuts or actions here if needed
    shortcut = {},
  },

  hide = {
    statusline = true,
    tabline = true,
    winbar = true,
  },

  -- preview = {
  --   command = "cat",
  --   file_path = "~/.config/nvim/lua/config/dashboard-header.txt",
  --   file_height = 12,
  --   file_width = 80,
  -- },
})
