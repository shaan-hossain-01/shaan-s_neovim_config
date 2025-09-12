-- Base Neovim LSP client configuration
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Global LSP keymaps (set unconditionally when Nvim starts)
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
    vim.keymap.set({"n", "v"}, "gra", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
    vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "LSP: References" })
    vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "LSP: Implementation" })
    vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "LSP: Type Definition" })
    vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, { desc = "LSP: Document Symbols" })
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Help" })
    
    -- Visual mode incremental selections
    vim.keymap.set("v", "an", function()
      if vim.lsp.buf.selection_range then
        vim.lsp.buf.selection_range()
      end
    end, { desc = "LSP: Outer incremental selection" })
    
    vim.keymap.set("v", "in", function()
      if vim.lsp.buf.selection_range then
        vim.lsp.buf.selection_range()
      end
    end, { desc = "LSP: Inner incremental selection" })
  end,
}
