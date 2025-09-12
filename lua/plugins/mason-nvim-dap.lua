-- mason-nvim-dap configuration - Automatic debug adapter installation
return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"mason.nvim",
		"mfussenegger/nvim-dap",
	},
	opts = {
		ensure_installed = {
			-- Node.js/JavaScript/TypeScript debugging
			"node2",
			"chrome",
			
			-- Python debugging
			"python",
			"debugpy",
			
			-- Go debugging
			"delve",
			
			-- C/C++/Rust debugging
			"codelldb",
			
			-- PHP debugging
			"php",
			
			-- Java debugging
			"java-debug-adapter",
			"java-test",
			
			-- .NET debugging
			"netcoredbg",
			
			-- Bash debugging
			"bash-debug-adapter",
		},
		automatic_installation = true,
		handlers = {
			function(config)
				-- Default handler - automatically setup debug adapters
				require("mason-nvim-dap").default_setup(config)
			end,
			
			-- Custom handler for Python
			python = function(config)
				config.adapters = {
					type = "executable",
					command = vim.fn.exepath("python"),
					args = { "-m", "debugpy.adapter" },
				}
				require("mason-nvim-dap").default_setup(config)
			end,
			
			-- Custom handler for Node.js
			node2 = function(config)
				config.adapters = {
					type = "executable",
					command = "node",
					args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
				}
				require("mason-nvim-dap").default_setup(config)
			end,
			
			-- Custom handler for Chrome debugging
			chrome = function(config)
				config.adapters = {
					type = "executable",
					command = "node",
					args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
				}
				require("mason-nvim-dap").default_setup(config)
			end,
		},
	},
	config = function(_, opts)
		require("mason-nvim-dap").setup(opts)
		
		-- Additional configurations after Mason DAP setup
		local dap = require("dap")
		
		-- Enhanced Node.js configuration with multiple scenarios
		dap.configurations.javascript = {
			{
				type = "node2",
				request = "launch",
				name = "Launch Node.js Program",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				type = "node2",
				request = "attach",
				name = "Attach to Node.js Process",
				processId = require("dap.utils").pick_process,
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
			},
			{
				type = "chrome",
				request = "launch",
				name = "Launch Chrome for Web Development",
				url = "http://localhost:3000",
				webRoot = "${workspaceFolder}",
				userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
			},
		}
		
		-- TypeScript uses same config as JavaScript
		dap.configurations.typescript = dap.configurations.javascript
		
		-- Enhanced Python configuration
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch Python File",
				program = "${file}",
				pythonPath = function()
					return vim.fn.exepath("python")
				end,
				console = "integratedTerminal",
				justMyCode = false,
			},
			{
				type = "python",
				request = "launch",
				name = "Launch Django",
				program = "${workspaceFolder}/manage.py",
				args = { "runserver", "--noreload" },
				pythonPath = function()
					return vim.fn.exepath("python")
				end,
				console = "integratedTerminal",
				justMyCode = false,
			},
			{
				type = "python",
				request = "launch",
				name = "Launch Flask",
				program = "${file}",
				env = {
					FLASK_APP = "${file}",
					FLASK_ENV = "development",
				},
				pythonPath = function()
					return vim.fn.exepath("python")
				end,
				console = "integratedTerminal",
				justMyCode = false,
			},
		}
		
		-- Go configuration
		dap.configurations.go = {
			{
				type = "delve",
				name = "Debug Go Program",
				request = "launch",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug Go Test",
				request = "launch",
				mode = "test",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug Go Package",
				request = "launch",
				program = "${fileDirname}",
			},
		}
		
		-- C/C++/Rust configuration using CodeLLDB
		local codelldb_config = {
			{
				name = "Launch C/C++ Program",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		
		dap.configurations.c = codelldb_config
		dap.configurations.cpp = codelldb_config
		dap.configurations.rust = {
			{
				name = "Launch Rust Program",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		
		-- PHP configuration
		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
				log = false,
				pathMappings = {
					["/var/www/html"] = "${workspaceFolder}",
				},
			},
		}
	end,
}