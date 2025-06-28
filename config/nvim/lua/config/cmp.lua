local cmp = require("cmp")
local lspkind = require("lspkind")

-- Merge codicons with custom icons
local icons = vim.tbl_extend("force", lspkind.presets.codicons, {
  Supermaven = "	",
  Copilot = "",
})

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
      side_padding = 0,
      col_offset = 0,
      max_width = 63,
      max_height = 7,
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    }),
    -- documentation = cmp.config.window.bordered({
    --   max_width = 100,
    --   max_height = 20,
    -- }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Inject custom kind for custom sources
      if entry.source.name == "supermaven" then
        vim_item.kind = "Supermaven"
      elseif entry.source.name == "copilot" then
        vim_item.kind = "Copilot"
      end

      return lspkind.cmp_format({
        mode = 'text_symbol',
        preset = "codicons",
        maxwidth = {
          menu = 50,
          abbr = 50,
        },
        show_labelDetails = true,
        ellipsis_char = "...",
        symbol_map = icons,
        before = function(_, item)
          local kind_text = item.kind

          -- Inject padded icon
          item.kind = "      " .. (icons[kind_text] or "")

          -- Kind label on right
          item.menu = kind_text

          return item
        end,
      })(entry, vim_item)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "supermaven" },
    -- { name = "copilot", group_index = 2 },
  }, {
    { name = "buffer" },
  }),
})

vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#a6e3a1", bold = true })
