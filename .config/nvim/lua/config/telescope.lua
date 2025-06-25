return function(opts)
  local map = vim.keymap.set
  local builtin = require("telescope.builtin")

  local SIZES = {
    HEIGHT = 0.7,
    WIDTH = 0.6,
    PREVIEW_WIDTH = 0.5,
  }

  map("n", "<leader>fa", function()
    builtin.find_files({
      follow = true,
      no_ignore = true,
      hidden = true,
      layout_config = {
        horizontal = {
          width = SIZES.WIDTH,
          height = SIZES.HEIGHT,
        },
      },
      prompt_prefix = " 󱡴  ",
      prompt_title = "All Files",
    })
  end, { desc = "Telescope search all files" })

  map("n", "<leader>ff", function()
    builtin.find_files({
      previewer = true,
      layout_config = {
        horizontal = {
          width = SIZES.WIDTH,
          height = SIZES.HEIGHT,
        },
        mirror = false,
      },
      prompt_title = "Files",
    })
  end, { desc = "Telescope search files" })

  map("n", "<leader>fo", function()
    builtin.oldfiles({
      layout_config = {
        horizontal = {
          width = SIZES.WIDTH,
          height = SIZES.HEIGHT,
        },
      },
      prompt_title = "Old Files",
    })
  end, { desc = "Telescope search recent files" })

  map("n", "<leader>fw", function()
    builtin.live_grep({
      layout_config = {
        vertical = {
          width = SIZES.WIDTH,
          height = SIZES.HEIGHT,
        },
      },
      prompt_title = "Live Grep",
    })
  end, { desc = "Telescope live grep" })

  map("n", "<leader>fb", function()
    builtin.buffers({
      layout_config = {
        horizontal = {
          width = SIZES.WIDTH,
          height = SIZES.HEIGHT,
        },
      },
    })
  end, { desc = "Telescope buffers" })

  -- Merge and return the final options
  return vim.tbl_deep_extend("force", opts, {
    defaults = {
      preview = {
        hide_on_startup = true,
      },
      results_title = false,
      selection_caret = " ",
      entry_prefix = " ",
      layout_config = {
        horizontal = {
          width = SIZES.WIDTH,
          height = SIZES.HEIGHT,
          preview_width = SIZES.PREVIEW_WIDTH,
        },
      },
      file_ignore_patterns = { "node_modules" },
      mappings = {
        i = {
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<C-h>"] = require("telescope.actions.layout").toggle_preview,
          ["<F1>"] = require("telescope.actions.layout").toggle_preview,
        },
        n = {
          ["<C-h>"] = require("telescope.actions.layout").toggle_preview,
          ["<F1>"] = require("telescope.actions.layout").toggle_preview,
        },
      },
    },
    pickers = {
      builtin = {
        prompt_title = "Builtin Pickers",
      },
    },
  })
end
