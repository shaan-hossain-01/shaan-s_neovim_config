return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets", -- A collection of snippets for various languages
  },
  config = function()
    local ls = require("luasnip")
    
    -- LuaSnip configuration
    ls.config.setup({
      -- This tells LuaSnip to remember to keep around the last snippet.
      -- You can jump back into it even if you move outside of the selection
      history = true,
      
      -- This one is cool cause if you have dynamic snippets, it updates as you type!
      updateevents = "TextChanged,TextChangedI",
      
      -- Autosnippets:
      enable_autosnippets = true,
      
      -- Crazy highlights!!
      -- #vid3
      -- This one is just for aesthetics.
      ext_opts = nil,
    })
    
    -- Load snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    
    -- Load snippets from custom snippets directory if it exists
    -- You can add your own snippets to ~/.config/nvim/snippets/
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    
    -- Framework-specific snippets extensions for full-stack development
    -- Add framework snippets to relevant filetypes
    require("luasnip").filetype_extend("ruby", {"rails"})
    require("luasnip").filetype_extend("javascript", {"react", "node"})
    require("luasnip").filetype_extend("typescript", {"react", "node"})
    require("luasnip").filetype_extend("javascriptreact", {"react"})
    require("luasnip").filetype_extend("typescriptreact", {"react"})
    require("luasnip").filetype_extend("python", {"django", "flask"})
    require("luasnip").filetype_extend("html", {"django-html"})
    require("luasnip").filetype_extend("css", {"tailwindcss"})
    require("luasnip").filetype_extend("php", {"laravel"})
    require("luasnip").filetype_extend("vue", {"vue"})
    require("luasnip").filetype_extend("go", {"gin", "echo"})
    require("luasnip").filetype_extend("java", {"spring"})
    require("luasnip").filetype_extend("sql", {"mysql", "postgresql"})
    require("luasnip").filetype_extend("dockerfile", {"docker"})
    require("luasnip").filetype_extend("yaml", {"kubernetes", "docker-compose"})
    
    -- Keymaps for LuaSnip
    vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

    vim.keymap.set({"i", "s"}, "<C-E>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, {silent = true})
  end,
}