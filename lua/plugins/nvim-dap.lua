return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- UI for nvim-dap which provides a good out of the box configuration
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {"nvim-neotest/nvim-nio"}
    },
    -- Virtual text for the debugger
    "theHamsta/nvim-dap-virtual-text",
    -- Mason integration for debug adapters
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    -- Setup nvim-dap-virtual-text
    dap_virtual_text.setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil
    })

    -- Setup nvim-dap-ui
    dapui.setup({
      icons = { expanded = "", collapsed = "", current_frame = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      element_mappings = {},
      expand_lines = vim.fn.has("nvim-0.7") == 1,
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 40, -- 40 columns
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25, -- 25% of total lines
          position = "bottom",
        },
      },
      controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      }
    })

    -- Auto-open and close dapui
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- DAP keymaps (following README recommendations)
    vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "DAP: Continue" })
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "DAP: Step Over" })
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "DAP: Step Into" })
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "DAP: Step Out" })
    
    -- Arrow keys for stepping (as recommended in README)
    vim.keymap.set('n', '<Down>', function() dap.step_over() end, { desc = "DAP: Step Over" })
    vim.keymap.set('n', '<Right>', function() dap.step_into() end, { desc = "DAP: Step Into" })
    vim.keymap.set('n', '<Left>', function() dap.step_out() end, { desc = "DAP: Step Out" })
    vim.keymap.set('n', '<Up>', function() dap.restart_frame() end, { desc = "DAP: Restart Frame" })
    
    -- Breakpoint keymaps
    vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
    vim.keymap.set('n', '<Leader>dB', function() 
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = "DAP: Set Conditional Breakpoint" })
    vim.keymap.set('n', '<Leader>dp', function() 
      dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end, { desc = "DAP: Set Log Point" })
    
    -- Session control
    vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = "DAP: Open REPL" })
    vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = "DAP: Run Last" })
    vim.keymap.set('n', '<Leader>dt', function() dap.terminate() end, { desc = "DAP: Terminate" })
    vim.keymap.set('n', '<Leader>dc', function() dap.clear_breakpoints() end, { desc = "DAP: Clear Breakpoints" })
    
    -- UI toggles
    vim.keymap.set('n', '<Leader>du', function() dapui.toggle() end, { desc = "DAP UI: Toggle" })
    vim.keymap.set('n', '<Leader>de', function() dapui.eval() end, { desc = "DAP UI: Eval" })
    vim.keymap.set('v', '<Leader>de', function() dapui.eval() end, { desc = "DAP UI: Eval Selection" })
    
    -- Widget inspection (hover for values)
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = "DAP: Hover Variables" })
    
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = "DAP: Preview" })
    
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end, { desc = "DAP: Show Frames" })
    
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end, { desc = "DAP: Show Scopes" })

    -- Basic debug configurations for common languages
    -- More specific configurations will be handled by mason-nvim-dap
    
    -- Generic configuration for any language that supports DAP
    dap.configurations.lua = {
      {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
      }
    }
  end,
}