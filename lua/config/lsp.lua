-- Not needed due to mason auto enabling (../plugins/lspconfig.lua)
-- vim.lsp.enable { 'basedpyright', 'ruff', 'lua_ls', 'rust_analyzer', 'zls', 'clangd', 'gopls', 'terraform-ls' }

-- Ty is not managed by mason for now
-- vim.lsp.enable { 'ty' }

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = true },
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
  desc = 'LSP: Toggle openFilesOnly for Pyright',
})
