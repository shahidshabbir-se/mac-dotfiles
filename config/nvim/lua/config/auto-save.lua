return {
  callbacks = {
    before_saving = function()
      -- Save global autoformat status
      vim.g.OLD_AUTOFORMAT = vim.g.autoformat_enabled
      vim.g.autoformat_enabled = false
      vim.g.OLD_AUTOFORMAT_BUFFERS = {}

      -- Disable all manually enabled buffers
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.b[bufnr].autoformat_enabled then
          table.insert(vim.g.OLD_AUTOFORMAT_BUFFERS, bufnr)
          vim.b[bufnr].autoformat_enabled = false
        end
      end
    end,

    after_saving = function()
      -- Restore global autoformat status
      -- vim.g.autoformat_enabled = vim.g.OLD_AUTOFORMAT

      -- Re-enable all manually enabled buffers
      for _, bufnr in ipairs(vim.g.OLD_AUTOFORMAT_BUFFERS or {}) do
        vim.b[bufnr].autoformat_enabled = true
      end
    end,
  },
}
