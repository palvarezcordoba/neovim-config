-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
  },
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', function(args)
      -- Check if the current line matches a python import regex
      local line = vim.api.nvim_get_current_line()
      local is_import = line:match '^%s*import%s+.*$' or line:match '^%s*from%s+.*$'
      if is_import then
        return
      end
      cmp_autopairs.on_confirm_done(args)
    end)
  end,
}
