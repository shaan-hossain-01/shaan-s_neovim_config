-- Aggregates per-plugin specs from lua/plugins/* modules
return {
	require("plugins.catppuccin"),
	require("plugins.telescope"),
	require("plugins.telescope-ui-select"),
	require("plugins.treesitter"),
	require("plugins.neo-tree"),
	require("plugins.lualine"),
	require("plugins.mason"),
		require("plugins.mason-lspconfig"),
		require("plugins.lspconfig"),
	require("plugins.none-ls"),
	require("plugins.nvim-cmp"),
	require("plugins.luasnip"),
	require("plugins.alpha"),
}

