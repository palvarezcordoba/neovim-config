return {
  -- ['js/ts.implicitProjectConfig.strictNullChecks'] = false,
  settings = {
    ts_ls = {
      init_options = {
        hostInfo = 'neovim',
      },
      tsdk = '/home/pablo/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib',
      ['typescript.tsdk'] = '/home/pablo/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib',
      typescript = {
        tsdk = '/home/pabdddlo/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib',
        enablePromptUseWorkspaceTsdk = true,
        inlayHints = {
          functionLikeReturnTypes = {
            enabled = true,
          },
          variableTypes = {
            enabled = true,
          },
          propertyDeclarationTypes = {
            enabled = true,
          },
          parameterNames = {
            enabled = 'all', -- literals, all, none
          },
        },
      },
    },
  },
  -- ---@param client vim.lsp.Client
  -- on_attach = function(client, _)
  --   client.server_capabilities.documentFormattingProvider = true
  --   client.server_capabilities.documentRangeFormattingProvider = true
  -- end,
}
