-- Lualine statusline
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local ok, lualine = pcall(require, "lualine")
    if not ok then return end
    lualine.setup({
      options = {
        theme = "auto",
        icons_enabled = true,
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = {}, winbar = {} },
      },
      sections = {
        lualine_c = {"filename", {
          'diagnostics',
          symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}}}
      }
    })
  end,
}
