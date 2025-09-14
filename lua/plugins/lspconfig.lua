-- Base Neovim LSP client configuration
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Global LSP keymaps (available for any buffer with LSP attached)
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })
    vim.keymap.set({'n', 'v'}, 'gra', vim.lsp.buf.code_action, { desc = 'LSP: Code action' })
    vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'LSP: References' })
    vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { desc = 'LSP: Implementation' })
    vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, { desc = 'LSP: Type definition' })
    vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, { desc = 'LSP: Document symbols' })
    vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature help' })
    
    -- Diagnostics (error/warning viewing like VS Code hover)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
    
    -- Selection range (expand/shrink visual selection based on LSP)
    vim.keymap.set('v', 'an', function()
      if vim.lsp.buf.selection_range then
        vim.lsp.buf.selection_range()
      end
    end, { desc = 'LSP: Expand selection range' })
    
    vim.keymap.set('v', 'in', function()
      if vim.lsp.buf.selection_range then
        vim.lsp.buf.selection_range()
      end
    end, { desc = 'LSP: Shrink selection range' })
  end,
}
