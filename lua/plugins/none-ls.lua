-- none-ls.nvim: Use Neovim as a language server (formatting, diagnostics, code actions)
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim", -- for additional sources like eslint
  },
  config = function()
    local null_ls = require("null-ls")

    -- Helper function to check if ESLint config exists
    local function eslint_config_exists()
      local config_files = {
        "eslint.config.js",
        "eslint.config.mjs", 
        "eslint.config.cjs",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json",
        ".eslintrc"
      }
      
      for _, config_file in ipairs(config_files) do
        if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. config_file) == 1 then
          return true
        end
      end
      return false
    end

    -- Build sources conditionally
    local sources = {
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
      
      -- Code Actions
      null_ls.builtins.code_actions.gitsigns, -- Git actions
      
      -- Completion
      null_ls.builtins.completion.spell, -- Spell checking
    }

    -- Add ESLint sources only if config exists
    if eslint_config_exists() then
      table.insert(sources, require("none-ls.diagnostics.eslint"))
      table.insert(sources, require("none-ls.code_actions.eslint"))
    end

    null_ls.setup({
      sources = sources,
    })
    
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
} 
