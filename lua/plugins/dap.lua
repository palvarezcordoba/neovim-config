local function python_path()
  local venv = vim.env.VIRTUAL_ENV
  if venv and venv ~= vim.NIL and venv ~= '' then
    return venv .. '/bin/python'
  end

  if vim.fn.executable '.venv/bin/python' == 1 then
    return '.venv/bin/python'
  end

  return 'python3'
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mfussenegger/nvim-dap-python',
    'rcarriga/nvim-dap-ui',
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
  },
  keys = {
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'DAP continue',
    },
    {
      '<F10>',
      function()
        require('dap').step_over()
      end,
      desc = 'DAP step over',
    },
    {
      '<F11>',
      function()
        require('dap').step_into()
      end,
      desc = 'DAP step into',
    },
    {
      '<F12>',
      function()
        require('dap').step_out()
      end,
      desc = 'DAP step out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'DAP toggle breakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'DAP conditional breakpoint',
    },
    {
      '<leader>dr',
      function()
        require('dap').restart_frame()
      end,
      desc = 'DAP restart frame',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'DAP run last',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'DAP toggle UI',
    },
    {
      '<leader>dx',
      function()
        require('dap').terminate()
      end,
      desc = 'DAP terminate',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    require('dap-python').setup(python_path())
  end,
}
