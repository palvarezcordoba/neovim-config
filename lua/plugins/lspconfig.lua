local language_servers = {
  'azure_pipelines_ls',
  'basedpyright',
  'csharp_ls',
  'dockerls',
  'eslint',
  'jsonls',
  'lua_ls',
  'ruff',
  'rust_analyzer',
  'stylua',
  'taplo',
  'terraformls',
  'ts_ls',
  'vale_ls',
  'yamlls',
  'zls',
}

local tools = {
  'fixjson',
  'prettier',
  'vale',
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = {
        ensure_installed = tools,
      },
    },
    {
      'mason-org/mason-lspconfig.nvim',
      opts = {
        automatic_enable = true,
        ensure_installed = language_servers,
      },
    },
    { 'j-hui/fidget.nvim', opts = {} },
  },
}
