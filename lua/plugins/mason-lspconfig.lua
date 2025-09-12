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
    -- MERN + Full-stack web development language servers
    local servers = {
      -- Core MERN (JS/TS/React ecosystem)
      "ts_ls",         -- TypeScript/JavaScript (formerly tsserver) - handles Next.js
      "eslint",        -- Linting
      "html",          -- HTML
      "cssls",         -- CSS
      "jsonls",        -- JSON
      "emmet_ls",      -- Emmet expansions
      "tailwindcss",   -- Tailwind CSS (common in React/Next.js)
      "graphql",       -- GraphQL (optional but common)
      
      -- Frontend frameworks & tools
      "svelte",        -- Svelte
      "angularls",     -- Angular
      "astro",         -- Astro framework
      
      -- Backend languages
      "pyright",       -- Python
      "rust_analyzer", -- Rust
      "gopls",         -- Go
      "jdtls",         -- Java
      "clangd",        -- C/C++
      "phpactor",      -- PHP
      "omnisharp",     -- C# (OmniSharp language server)
      
      -- Databases & Query languages
      "sqlls",         -- SQL
      "prismals",      -- Prisma ORM
      
      -- DevOps & Infrastructure
      "bashls",        -- Bash
      "yamlls",        -- YAML
      "dockerls",      -- Docker
      "terraformls",   -- Terraform
      "helm_ls",       -- Helm charts
      
      -- Linux scripting & system administration
      "powershell_es", -- PowerShell
      "awk_ls",        -- AWK scripting
      "zls",           -- Zig (systems programming)
      
      -- Configuration & Markup
      "marksman",      -- Markdown
      "lemminx",       -- XML
      "taplo",         -- TOML
      
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
      if type(mlsp.setup_handlers) == "function" then
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
      else
        -- Fallback for older mason-lspconfig: setup all installed servers
        for _, server_name in ipairs(servers) do
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
          else
            lspconfig[server_name].setup({})
          end
        end
      end
  end,
}
