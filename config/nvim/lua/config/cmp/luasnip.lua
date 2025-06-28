local luasnip = require("luasnip")

luasnip.config.set_config({})

luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })
luasnip.filetype_extend("svelte", { "html" })

-- Optional: Load community or custom snippets
pcall(require, "nvchad.configs.luasnip")
