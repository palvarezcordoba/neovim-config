return {
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      completion = {
        fullFunctionSignatures = true,
      },
      -- diagnostics = {
      --   styleLints = {
      --     enable = true,
      --   }
      -- },
      inlayHints = {
        bindingModeHints = { enable = true },
        -- closureCaptureHints = { enable = true },
      },
    },
  },
}
