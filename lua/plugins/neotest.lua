return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-python',
    'rouge8/neotest-rust',
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    {
      '<leader>tn',
      function()
        require('neotest').run.run()
      end,
      desc = 'Test: nearest',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Test: file',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = 'Test: output',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Test: summary',
    },
  },
  config = function()
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

    ---@diagnostic disable-next-line: missing-fields
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          runner = 'pytest',
          python = python_path(),
        },
        require 'neotest-rust',
      },
    }
    vim.api.nvim_create_user_command('NeoTestNearVerbose', function()
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').run.run { extra_args = { '-vv' } }
    end, { nargs = 0 })
    vim.api.nvim_create_user_command('NeoTestNearDebug', function()
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').run.run { strategy = 'dap' }
    end, { nargs = 0 })
  end,
}
