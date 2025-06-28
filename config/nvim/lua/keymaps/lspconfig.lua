local M = {}

function M.on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  map("n", "gr", vim.lsp.buf.references, "Show References")
  map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Lspsaga Hover")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
  map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format Buffer")
end

return M
