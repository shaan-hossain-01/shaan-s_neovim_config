-- Treesitter spec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
        "javascript", "typescript", "tsx", "html", "css", "scss", "json", "jsonc",
        "python", "go", "rust", "java", "php", "ruby", "sql", "yaml", "toml",
        "bash", "dockerfile", "graphql", "prisma", "svelte", "vue",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = {
        enable = true,
        disable = {},
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
