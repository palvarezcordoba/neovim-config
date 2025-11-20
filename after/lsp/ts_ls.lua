return {
  -- ['js/ts.implicitProjectConfig.strictNullChecks'] = false,
  settings = {
    ts_ls = {
      init_options = {
        hostInfo = 'neovim',
      },
      tsdk = '/home/pabdddlo/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib',
      ['typescript.tsdk'] = '/home/pabdddlo/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib',
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
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true
  end,
}
