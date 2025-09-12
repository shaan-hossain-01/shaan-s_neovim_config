return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help", -- Enhanced function signature help
    "L3MON4D3/LuaSnip", -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- LuaSnip completion source
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = function(entry, vim_item)
          -- Show source name in completion menu
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lsp_signature_help = "[Signature]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "nvim_lsp_signature_help", priority = 1000 },
        { name = "luasnip", priority = 750 }, -- For luasnip users.
      }, {
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }),
    })

    -- Enhanced filetype-specific configurations for full-stack development
    
    -- JavaScript/TypeScript/React/Next.js specific
    cmp.setup.filetype({ "javascript", "typescript", "javascriptreact", "typescriptreact" }, {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "nvim_lsp_signature_help", priority = 1000 },
        { name = "luasnip", priority = 750 },
      }, {
        { name = "buffer", priority = 500, keyword_length = 3 },
        { name = "path", priority = 250 },
      }),
    })

    -- CSS/SCSS/Tailwind specific
    cmp.setup.filetype({ "css", "scss", "less" }, {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
      }, {
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }),
    })

    -- HTML/JSX/Vue specific
    cmp.setup.filetype({ "html", "vue" }, {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
      }, {
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }),
    })

    -- Python specific
    cmp.setup.filetype("python", {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "nvim_lsp_signature_help", priority = 1000 },
        { name = "luasnip", priority = 750 },
      }, {
        { name = "buffer", priority = 500, keyword_length = 3 },
        { name = "path", priority = 250 },
      }),
    })

    -- JSON specific (package.json, tsconfig.json, etc.)
    cmp.setup.filetype("json", {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
      }, {
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }),
    })

    -- Dockerfile specific
    cmp.setup.filetype("dockerfile", {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
      }, {
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }),
    })

    -- Git commit messages
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "buffer", priority = 1000 },
      }),
    })

    -- Markdown specific
    cmp.setup.filetype("markdown", {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
      }, {
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}