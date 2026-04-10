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

vim.api.nvim_create_user_command('PyrightSetVenv', function(opts)
  local venv_path = opts.args

  if venv_path == '' then
    vim.notify('Please provide a path to the virtual environment.', vim.log.levels.WARN, { title = 'LSP' })
    return
  end

  vim.lsp.config('basedpyright', {
    settings = {
      python = {
        pythonPath = venv_path .. '/bin/python',
      },
    },
  })

  vim.lsp.enable('basedpyright', false)
  vim.lsp.enable('basedpyright', true)

  vim.notify('Pyright virtual environment set to: ' .. venv_path, vim.log.levels.INFO, { title = 'LSP' })
end, {
  desc = 'LSP: Set Pyright virtual environment path',
  nargs = 1,

  -- Tab completion
  complete = function(arglead)
    -- Expand ~ and other vim-style prefixes
    local lead = vim.fn.expand(arglead)

    -- List matching directories
    local matches = vim.fn.glob(lead .. '*', true, true)

    -- Filter to dirs and prefer common venv folder names
    local preferred = {}
    local others = {}

    for _, p in ipairs(matches) do
      if vim.fn.isdirectory(p) == 1 then
        local name = vim.fn.fnamemodify(p, ':t')
        if name == '.venv' or name == 'venv' or name == 'env' or name == '.env' then
          table.insert(preferred, p)
        else
          table.insert(others, p)
        end
      end
    end

    -- Return in a nice order
    local out = {}
    vim.list_extend(out, preferred)
    vim.list_extend(out, others)
    return out
  end,
})
