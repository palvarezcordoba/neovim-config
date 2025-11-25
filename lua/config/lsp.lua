-- Not needed due to mason
-- vim.lsp.enable { 'basedpyright', 'ruff', 'lua_ls', 'rust_analyzer', 'zls', 'clangd', 'gopls', 'terraform-ls' }

-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  -- virtual_lines = {
  --   current_line = true,
  --   severity = { min = vim.diagnostic.severity.WARN },
  -- },
  severity_sort = true,
  -- update_in_insert = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}



local open_files_only = true
local function switch_openfiles_only()
  open_files_only = not open_files_only
  vim.lsp.config('basedpyright', {
    settings = {
      basedpyright = {
        openFilesOnly = open_files_only,
        analysis = {
          diagnosticMode = open_files_only and 'openFilesOnly' or 'workspace',
        },
      },
    },
  })
  vim.lsp.enable('basedpyright', false)
  vim.lsp.enable('basedpyright', true)
end

vim.api.nvim_create_user_command('ToggleOpenFilesOnly', switch_openfiles_only, {
  desc = 'Toggle openFilesOnly for Pyright',
})

