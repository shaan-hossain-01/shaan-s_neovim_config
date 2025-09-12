-- none-ls.nvim: Use Neovim as a language server (formatting, diagnostics, code actions)
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim", -- for additional sources like eslint
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Formatting
        null_ls.builtins.formatting.prettier.with({
          filetypes = { 
            "javascript", "typescript", "javascriptreact", "typescriptreact",
            "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown",
            "graphql", "handlebars"
          },
        }),
        null_ls.builtins.formatting.stylua, -- Lua formatting
        null_ls.builtins.formatting.black, -- Python formatting
        null_ls.builtins.formatting.isort, -- Python import sorting
        null_ls.builtins.formatting.gofmt, -- Go formatting
        null_ls.builtins.formatting.shfmt, -- Shell script formatting
        
        -- Diagnostics & Linting
        require("none-ls.diagnostics.eslint"), -- JavaScript/TypeScript linting
        
        -- Code Actions
        require("none-ls.code_actions.eslint"), -- ESLint code actions
        null_ls.builtins.code_actions.gitsigns, -- Git actions
        
        -- Completion
        null_ls.builtins.completion.spell, -- Spell checking
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
} 
