return {
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "onsails/lspkind.nvim" },
      { "L3MON4D3/LuaSnip",    config = function() require("config.cmp.luasnip") end },
      { "hrsh7th/cmp-cmdline", event = "CmdlineEnter",                               config = function() require(
        "config.cmp.cmdline") end },
    },
    config = function()
      require("config.cmp")
    end,
  },
}
