-- mason-lspconfig: bridge Mason with nvim-lspconfig
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {},
  config = function(_, opts)
    -- Ensure Mason and mason-lspconfig are set up
    require("mason").setup({})
    local mlsp = require("mason-lspconfig")
    -- MERN + Lua language servers
    local servers = {
      -- Core MERN (JS/TS/React ecosystem)
      "tsserver",      -- TypeScript/JavaScript
      "eslint",        -- Linting
      "html",          -- HTML
      "cssls",         -- CSS
      "jsonls",        -- JSON
      "emmet_ls",      -- Emmet expansions
      "tailwindcss",   -- Tailwind CSS (common in React)
      "graphql",       -- GraphQL (optional but common)
      -- Useful tooling
      "bashls",
      "yamlls",
      "dockerls",
      -- Lua for Neovim config/dev
      "lua_ls",
    }

    mlsp.setup(vim.tbl_extend("force", {
      ensure_installed = servers,
      automatic_installation = true,
    }, opts or {}))

    -- Minimal example: automatic default setup for installed servers
  local lspconfig = require("lspconfig")

    -- Optional: if you want to ensure some servers are installed by Mason
    -- mlsp.setup({ ensure_installed = { "lua_ls", "ts_ls", "pyright" } })

    -- Use mason-lspconfig handler to set up each server with defaults
    mlsp.setup_handlers({
      function(server_name)
        if server_name == "lua_ls" then
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          })
          return
        end
        lspconfig[server_name].setup({})
      end,
    })
  end,
}
