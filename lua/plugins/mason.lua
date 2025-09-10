-- Mason: Portable package manager (LSP/DAP/Formatters)
return {
  "mason-org/mason.nvim",
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts or {})
  end,
}
