# Shaan's Neovim Config (Lazy.nvim)

A modular Neovim configuration using lazy.nvim, optimized for MERN/full‑stack web development with robust LSP, Treesitter, Telescope, formatting, and a pleasant UI.

- Leader: Space (`<Space>`)
- Localleader: `\`
- Plugin manager: folke/lazy.nvim (bootstrapped in `init.lua`)

## Folder structure
- `init.lua` — core options, lazy.nvim bootstrap, global keymaps
- `lua/plugins.lua` — aggregator that requires each plugin module
- `lua/plugins/*.lua` — one module per plugin (spec + config)

## Plugins and what they do

- Theme: `catppuccin/nvim`
  - Mocha flavour; integrates with Treesitter, Gitsigns, etc.; sets colorscheme automatically.

- Fuzzy finding: `nvim-telescope/telescope.nvim`
  - Files, grep, buffers, help; extended via `telescope-ui-select`.
- UI select: `nvim-telescope/telescope-ui-select.nvim`
  - Replaces `vim.ui.select` with Telescope dropdown; extension is configured and loaded.

- Syntax/AST: `nvim-treesitter/nvim-treesitter`
  - Highlighting, indentation, and folding. Parsers auto-install; Treesitter folding enabled globally.

- File explorer: `nvim-neo-tree/neo-tree.nvim`
  - Modern tree with icons via `nvim-web-devicons` and UI via `nui.nvim`. Eager-loaded.

- Statusline: `nvim-lualine/lualine.nvim`
  - Global statusline with icons; theme auto; default separators.

- External tools: `mason-org/mason.nvim`
  - Manages LSP servers, linters, formatters.
- LSP bridge: `mason-org/mason-lspconfig.nvim`
  - Auto-installs and configures LSP servers with lspconfig.
- LSP client: `neovim/nvim-lspconfig`
  - Base LSP setup + global keymaps for LSP actions.

- Formatting/Diagnostics: `nvimtools/none-ls.nvim` (+ `nvimtools/none-ls-extras.nvim`)
  - Unifies non-LSP tools:
    - Formatting: Prettier (JS/TS/React/Vue/CSS/HTML/JSON/YAML/Markdown/GraphQL), StyLua, Black, isort, gofmt, shfmt
    - Diagnostics: ESLint
    - Code actions: ESLint, Gitsigns
    - Completion: Spell
  - Map: `<leader>gf` to format via LSP (works with none-ls too)

- Dashboard: `goolord/alpha-nvim`
  - Start screen using `startify` theme with custom ASCII header.

## LSP servers (installed by Mason)
Configured in `lua/plugins/mason-lspconfig.lua` with `ensure_installed`:

- JavaScript/TypeScript: `ts_ls`, `eslint`, `html`, `cssls`, `jsonls`, `emmet_ls`, `tailwindcss`, `graphql`
- Frontend frameworks: `svelte`, `angularls`, `astro`
- Backend: `pyright`, `rust_analyzer`, `gopls`, `jdtls`, `clangd`, `phpactor`, `omnisharp`
- Databases/ORM: `sqlls`, `prismals`
- DevOps: `bashls`, `yamlls`, `dockerls`, `terraformls`, `helm_ls`
- Linux scripting/system: `powershell_es`, `awk_ls`, `zls`
- Markup/Config: `marksman`, `lemminx`, `taplo`
- Neovim/Lua: `lua_ls`

Lua LS is tuned to recognize the `vim` global and Neovim runtime files.

## Keybindings (complete list)

Global mappings configured across the config. They do not require buffer-local setup.

Telescope (from `init.lua`):
- Normal `<leader>ff` — Find files (`telescope.builtin.find_files`)
- Normal `<leader>fg` — Live grep (`telescope.builtin.live_grep`)
- Normal `<leader>fb` — List buffers (`telescope.builtin.buffers`)
- Normal `<leader>fh` — Help tags (`telescope.builtin.help_tags`)

Neo-tree (from `init.lua`):
- Normal `<C-n>` — Reveal filesystem tree on the left (`:Neotree filesystem reveal left`)

LSP core (from `lua/plugins/lspconfig.lua`):
- Normal `grn` — Rename symbol (`vim.lsp.buf.rename`)
- Normal/Visual `gra` — Code action (`vim.lsp.buf.code_action`)
- Normal `grr` — References (`vim.lsp.buf.references`)
- Normal `gri` — Go to implementation (`vim.lsp.buf.implementation`)
- Normal `grt` — Go to type definition (`vim.lsp.buf.type_definition`)
- Normal `gO` — Document symbol outline (`vim.lsp.buf.document_symbol`)
- Insert `<C-s>` — Signature help (`vim.lsp.buf.signature_help`)
- Visual `an` — Expand to outer selection (`vim.lsp.buf.selection_range`)
- Visual `in` — Shrink to inner selection (`vim.lsp.buf.selection_range`)

Formatting (from `lua/plugins/none-ls.lua`):
- Normal `<leader>gf` — Format buffer via LSP (none-ls / server formatting)

## Usage notes and tips
- Treesitter folding: enabled via `foldmethod=expr` and `foldexpr=nvim_treesitter#foldexpr()`.
- Telescope UI Select: improves any `vim.ui.select` based prompts (e.g., code actions).
- None-ls tools require binaries on your system:
  - Prettier: `npm i -g prettier`
  - Black, isort: `pip install black isort`
  - gofmt/shfmt: `go` and `shfmt` available in PATH
  - ESLint: project-local or global install recommended (`npm i -D eslint` or `npm i -g eslint`)
- Use `:LspInfo` to check attached servers, and `:Mason` to manage tool installs.

## Install / Update
1) Start Neovim to bootstrap lazy.nvim.
2) `:Lazy sync` to install/update plugins.
3) `:Mason` to install external tools; missing ones will auto-install where configured.
4) Open a file and use the keymaps above. Formatting: `<leader>gf`.

## Troubleshooting
- If Mason fails to install a server: open `:Mason` then press `i` to install; check `:MasonLog` for details.
- If none-ls complains about a builtin, ensure the corresponding binary is installed or remove that source.
- For TS/JS in monorepos, prefer project-local ESLint/Prettier for correct config resolution.
