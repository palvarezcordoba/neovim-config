return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    {
      'mason-org/mason-lspconfig.nvim',
      opts = {
        ensure_installed = {
          'pyright',
          'ruff',
          'lua_ls',
          'ts_ls',
          'jsonls',
          'dockerls',
          'yamlls',
          'rust_analyzer',
        },
        automatic_enable = true,
      },
    },
    { 'j-hui/fidget.nvim', opts = {} },
  },
}
