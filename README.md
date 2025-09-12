# Shaan's Neovim Config (Lazy.nvim)

A clean, modular Neovim setup powered by lazy.nvim. It’s optimized for MERN/full‑stack development and ships with first‑class LSP, Treesitter, Telescope, formatting, completion/snippets, and an integrated Debugger (DAP) UI.

- Leader: Space (`<Space>`)
- Localleader: `\`
- Plugin manager: folke/lazy.nvim (bootstrapped in `init.lua`)

## Structure

- `init.lua` — core options, lazy bootstrap, leader keys, global keymaps
- `lua/plugins.lua` — plugin aggregator (one `require` per plugin module)
- `lua/plugins/*.lua` — one file per plugin (spec + config)
- `snippets/` — optional VS Code–style custom snippets loaded by LuaSnip

## Plugin catalog (what each one adds)

- Theme: `catppuccin/nvim`

  - Beautiful theme (Mocha by default) with integrations for Treesitter, cmp, etc.; transparent background enabled.

- Finder: `nvim-telescope/telescope.nvim` (+ `nvim-lua/plenary.nvim`)

  - Fast fuzzy finding for files, grep, buffers, help. Extensible.
  - UI Select: `telescope-ui-select.nvim` replaces `vim.ui.select` with a Telescope picker.

- Syntax/AST: `nvim-treesitter/nvim-treesitter`

  - Modern highlighting, indentation, and folding. Parsers auto‑install. Treesitter folding enabled globally with 0.9/0.10 compatibility.

- File explorer: `nvim-neo-tree/neo-tree.nvim`

  - Modern tree view (icons via `nvim-web-devicons`, UI via `nui.nvim`), eager‑loaded for quick access.

- Statusline: `nvim-lualine/lualine.nvim`

  - Polished, icon‑aware statusline; global status with nice separators.

- Package manager: `mason-org/mason.nvim`

  - Installs language servers, formatters, linters, and debug adapters.

- LSP bridge: `mason-org/mason-lspconfig.nvim`

  - Auto‑installs and wires LSP servers into nvim‑lspconfig; injects cmp capabilities.

- LSP client: `neovim/nvim-lspconfig`

  - Core LSP client plus global LSP keymaps (rename, code actions, references, etc.).

- Formatting/Diagnostics: `nvimtools/none-ls.nvim` (+ `nvimtools/none-ls-extras.nvim`)

  - Use external tools via LSP: Prettier, StyLua, Black, isort, gofmt, shfmt, ESLint diagnostics/actions, Gitsigns actions, Spell completion.

- Completion: `hrsh7th/nvim-cmp`

  - Completion menu with bordered windows, per‑filetype sources, and cmdline completion.
  - Sources: `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `cmp-cmdline`, `cmp-nvim-lsp-signature-help`.

- Snippets: `L3MON4D3/LuaSnip`

  - Powerful snippet engine with history, autosnippets, and live updates; integrates with cmp via `cmp_luasnip`.
  - Snippet collections: `rafamadriz/friendly-snippets` (auto‑loaded) + your custom `snippets/` folder.

- Dashboard: `goolord/alpha-nvim`

  - Aesthetic start screen using the Startify theme and custom header.

- Debugging (DAP): `mfussenegger/nvim-dap`
  - Core DAP client with rich keymaps and REPL.
  - UI: `rcarriga/nvim-dap-ui` (+ `nvim-neotest/nvim-nio`) — sidebars (scopes, stacks, watches, breakpoints), REPL/console tray, controls.
  - Inline values: `theHamsta/nvim-dap-virtual-text` — show variable values inline.
  - Adapter manager: `jay-babu/mason-nvim-dap.nvim` — auto‑installs adapters and wires language configs.

### Supporting dependencies

- `nvim-lua/plenary.nvim` — Lua helper library used by many plugins.
- `nvim-tree/nvim-web-devicons` — filetype/devicons for UI polish (neo-tree, lualine, alpha).
- `MunifTanjim/nui.nvim` — UI primitives used by neo-tree.
- `hrsh7th/cmp-*` — cmp sources: nvim-lsp, buffer, path, cmdline, signature-help.
- `saadparwaiz1/cmp_luasnip` — connect cmp with LuaSnip.
- `rafamadriz/friendly-snippets` — community snippets collection.
- `nvim-neotest/nvim-nio` — async primitives required by dap-ui.
- `nvimtools/none-ls-extras.nvim` — extra sources (e.g., ESLint) for none-ls.

## LSP servers (auto‑installed by Mason)

From `lua/plugins/mason-lspconfig.lua`:

- Web core: `ts_ls`, `eslint`, `html`, `cssls`, `jsonls`, `emmet_ls`, `tailwindcss`, `graphql`
- Frameworks: `svelte`, `angularls`, `astro`
- Backend: `pyright`, `rust_analyzer`, `gopls`, `jdtls`, `clangd`, `phpactor`, `omnisharp`
- Data/ORM: `sqlls`, `prismals`
- DevOps: `bashls`, `yamlls`, `dockerls`, `terraformls`, `helm_ls`
- System: `powershell_es`, `awk_ls`, `zls`
- Markup/Config: `marksman`, `lemminx`, `taplo`
- Neovim: `lua_ls` (pre‑configured to recognize the `vim` global and runtime files)

## DAP adapters (auto‑installed by Mason)

From `lua/plugins/mason-nvim-dap.lua`:

- JavaScript/TypeScript: `node2`, `chrome`
- Python: `python`, `debugpy`
- Go: `delve`
- C/C++/Rust: `codelldb`
- PHP: `php` (Xdebug)
- Java: `java-debug-adapter`, `java-test`
- .NET: `netcoredbg`
- Bash: `bash-debug-adapter`

Language configurations for JS/TS, Python (incl. Django/Flask), Go, C/C++/Rust, PHP are pre‑wired.

## Keybindings (complete)

Global mappings defined in this config, grouped by feature.

Telescope (from `init.lua`)

- Normal `<leader>ff` — Find files
- Normal `<leader>fg` — Live grep
- Normal `<leader>fb` — Buffers
- Normal `<leader>fh` — Help tags

Neo‑tree (from `init.lua`)

- Normal `<C-n>` — Reveal filesystem tree on the left

LSP (from `lua/plugins/lspconfig.lua`)

- Normal `grn` — Rename symbol
- Normal/Visual `gra` — Code action
- Normal `grr` — References
- Normal `gri` — Go to implementation
- Normal `grt` — Go to type definition
- Normal `gO` — Document symbols
- Insert `<C-s>` — Signature help
- Visual `an` — Selection range (outer)
- Visual `in` — Selection range (inner)

Formatting (from `lua/plugins/none-ls.lua`)

- Normal `<leader>gf` — Format buffer via LSP

Snippets (from `lua/plugins/luasnip.lua`)

- Insert `<C-K>` — Expand snippet
- Insert/Select `<C-L>` — Jump forward in snippet
- Insert/Select `<C-J>` — Jump backward in snippet
- Insert/Select `<C-E>` — Cycle choices in a choice node (when active)

Completion (from `lua/plugins/nvim-cmp.lua`)

- Insert `<C-b>` / `<C-f>` — Scroll docs up/down
- Insert `<C-Space>` — Trigger completion
- Insert `<C-e>` — Abort completion
- Insert `<CR>` — Confirm selection (select = true)
- Insert/Select `<Tab>` — Next item or expand/jump snippet
- Insert/Select `<S-Tab>` — Previous item or jump backward in snippet
- Cmdline `/` or `?` — Buffer source completion
- Cmdline `:` — Path + cmdline completion

Debugging (DAP) (from `lua/plugins/nvim-dap.lua`)

- Normal `<F5>` — Continue/Start
- Normal `<F10>` — Step over
- Normal `<F11>` — Step into
- Normal `<F12>` — Step out
- Normal `<Down>` — Step over
- Normal `<Right>` — Step into
- Normal `<Left>` — Step out
- Normal `<Up>` — Restart frame
- Normal `<leader>db` — Toggle breakpoint
- Normal `<leader>dB` — Conditional breakpoint (prompts condition)
- Normal `<leader>dp` — Log point (prompts message)
- Normal `<leader>dr` — Open REPL
- Normal `<leader>dl` — Run last
- Normal `<leader>dt` — Terminate
- Normal `<leader>dc` — Clear all breakpoints
- Normal `<leader>du` — Toggle DAP UI
- Normal `<leader>de` — Evaluate expression under cursor
- Visual `<leader>de` — Evaluate selection
- Normal `<leader>dh` — Hover variables (widget)
- Normal `<leader>df` — Show frames (floating)
- Normal `<leader>ds` — Show scopes (floating)

## Usage

- Search & navigate: Use Telescope maps (`<leader>ff`, `<leader>fg`, etc.).
- Explore files: `<C-n>` to toggle Neo‑tree on the left.
- LSP workflow: rename with `grn`, code actions `gra`, references `grr`, signature help `<C-s>` in insert mode.
- Format: `<leader>gf` (uses server formatting or none‑ls sources where applicable).
- Snippets: expand with `<C-K>`, jump with `<C-L>`/`<C-J>`, choice with `<C-E>`.
- Completion: `<C-Space>` to trigger; `<Tab>/<S-Tab>` to navigate or jump snippet fields; `<CR>` to confirm.
- Debugging: set breakpoints (`<leader>db`), start (`<F5>`), step (`<F10>/<F11>/<F12>`), inspect variables (`<leader>de`, `<leader>dh>`); UI auto‑opens on session start.

## Settings & quality of life

- Treesitter folding is enabled with version‑aware foldexpr (works on 0.9 and 0.10+).
- Telescope UI Select augments any `vim.ui.select` prompt (e.g., code actions pickers).
- Catppuccin theme with transparent background, global statusline (lualine).
- Lazy checker enabled for auto plugin updates.

## Install / Update

1. Start Neovim; `lazy.nvim` bootstraps automatically.
2. Run `:Lazy sync` to install/update plugins.
3. Open `:Mason` to manage external tools (LSP/formatters/dap). Most will auto‑install on demand.
4. Start coding. Use keymaps above; open DAP UI by starting a debug session with `<F5>`.

## Troubleshooting

- Mason install issues: open `:Mason`, (re)install items, and check `:MasonLog` if needed.
- none‑ls: ensure corresponding binaries are installed (Prettier, Black, isort, gofmt, shfmt, ESLint, etc.). Remove unused sources if you don’t need them.
- JS/TS monorepos: prefer project‑local ESLint/Prettier so config resolution matches the repo.
- DAP adapters: make sure project tools are runnable (e.g., `python`, `node`, `go`, compiled binaries for codelldb targets`).
