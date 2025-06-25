local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
      side_padding = 0, -- padding inside the popup
      col_offset = 0,   -- how far from the cursor
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      max_width = 63,   -- wider popup menu
      max_height = 7,
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
    format = lspkind.cmp_format({
      mode = 'text_symbol', -- show only symbol annotations
      preset = 'codicons',
      maxwidth = {
        menu = 50, -- leading text (labelDetails)
        abbr = 50, -- actual suggestion item
      },
      symbol_map = { Copilot = "" },
      ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        local kind_icons = require("lspkind").presets.default
        local kind_text = vim_item.kind

        -- icon + extra space
        vim_item.kind = "      " .. (kind_icons[kind_text] or "")

        -- kind label on right
        vim_item.menu = kind_text

        -- ...
        return vim_item
      end
    }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "copilot", group_index = 2 },
  }, {
    { name = "buffer" },
  }),
})
