# Shaan's Neovim Config (Lazy.nvim)

A modular Neovim configuration using lazy.nvim with a focus on MERN/full‑stack web development and strong LSP/Telescope ergonomics.

## Plugins

- catppuccin/nvim (Catppuccin)
  - Theme with mocha flavour and integrations for Treesitter, Gitsigns, etc.
- nvim-telescope/telescope.nvim
  - Fuzzy finder for files, buffers, help, live grep; extended with ui-select.
- nvim-telescope/telescope-ui-select.nvim
  - Replaces `vim.ui.select` with Telescope’s dropdown for nicer selection UIs.
- nvim-treesitter/nvim-treesitter
  - Better syntax highlighting, indentation, and folding. Parsers auto-install.
- nvim-neo-tree/neo-tree.nvim
  - File explorer with icons, using nui.nvim; eager-loaded.
- nvim-lualine/lualine.nvim
  - Statusline with icons and global status enabled.
- mason-org/mason.nvim
  - Manages external tools (LSPs, DAP, formatters).
- mason-org/mason-lspconfig.nvim
  - Bridges Mason with nvim-lspconfig, auto-installs and configures servers.
- neovim/nvim-lspconfig
  - Base LSP client configuration and global LSP keybindings.

## LSP Servers (ensure_installed)
From mason-lspconfig setup:
- JavaScript/TypeScript: ts_ls, eslint, html, cssls, jsonls, emmet_ls, tailwindcss, graphql
- Frontend frameworks: svelte, vue, angularls, astro
- Backend: pyright, rust_analyzer, gopls, jdtls, clangd, phpactor, ruby_ls, csharp_ls
- Databases/ORM: sqlls, prismals
- DevOps: bashls, yamlls, dockerls, terraformls, helm_ls
- Linux scripting/system: powershell_es, awk_ls, zls
- Markup/Config: marksman, lemminx, taplo
- Neovim/Lua: lua_ls

## Keybindings

### Global (init.lua + LSP)
- Telescope
  - <leader>ff — Find files (telescope.builtin.find_files)
  - <leader>fg — Live grep (telescope.builtin.live_grep)
  - <leader>fb — Buffers (telescope.builtin.buffers)
  - <leader>fh — Help tags (telescope.builtin.help_tags)
- Neo-tree
  - Ctrl-n — Reveal filesystem tree on the left
- LSP (set globally by nvim-lspconfig)
  - grn — Rename symbol (vim.lsp.buf.rename)
  - gra — Code actions (normal/visual) (vim.lsp.buf.code_action)
  - grr — References (vim.lsp.buf.references)
  - gri — Go to implementation (vim.lsp.buf.implementation)
  - grt — Go to type definition (vim.lsp.buf.type_definition)
  - gO — Document symbols (vim.lsp.buf.document_symbol)
  - Insert Ctrl-S — Signature help (vim.lsp.buf.signature_help)
  - Visual an — Outer incremental selection (vim.lsp.buf.selection_range)
  - Visual in — Inner incremental selection (vim.lsp.buf.selection_range)

## Use cases
- Find files/text quickly with Telescope mappings.
- Browse project structure with Neo-tree (Ctrl-n) and open/reveal files.
- Rich syntax highlighting, indentation, and folding via Treesitter.
- LSP productivity:
  - Rename (grn), code actions (gra), and references (grr) for fast refactors.
  - Jump to implementations (gri) and types (grt) while navigating codebases.
  - Inspect document symbols (gO) to jump across functions/types quickly.
  - Signature help in insert mode (Ctrl-S) while typing function calls.
  - Expand/contract selection semantically (an/in) using LSP selection ranges.

## Notes
- Leader key: Space (" "), Localleader: \
- Treesitter-based folding is enabled by default.
- Telescope UI-select is loaded and configured to theme dropdown.
- Mason auto-installs listed LSP servers; they’re set up via mason-lspconfig.

## Getting started
1. Install Neovim 0.9+.
2. Start Neovim to bootstrap lazy.nvim.
3. Run `:Lazy sync` to install/update plugins.
4. Run `:Mason` to view/install external tools; open a file to activate LSP.
5. Use `:LspInfo` to verify active servers.
