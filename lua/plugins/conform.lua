return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    formatters = {
      -- opts for ruff from default config
      -- uses force exclude. I want to format all files,
      -- even excluded ones, since it's not possible
      -- to exclude files from linting but not formatting
      -- in ruff
      ruff_format = {
        args = {
          'format',
          '--stdin-filename',
          '$FILENAME',
          '-',
        },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format', 'ruff_organize_imports', 'ruff_fix' },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        require('conform').format { bufnr = args.buf }
      end,
    })
  end,
}
