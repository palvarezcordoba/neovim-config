return {
  settings = {
    pyright = {
      openFilesOnly = false,
      disableOrganizeImports = true,
    },
    python = {
      -- pythonPath = vim.fn.getcwd() .. '/.venv/bin/python',
      analysis = {
        -- diagnosticMode = 'openFilesOnly',
        diagnosticMode = 'workspace',
        autoImportCompletions = true,
        typeCheckingMode = 'standard',
        diagnosticSeverityOverrides = {
          reportMissingTypeArgument = 'error',
          -- both ruff and pyright complain about unused imports
          -- so disable it for pyright
          reportUnusedImport = 'none',
          strictListInference = true,
          strictDictionaryInference = true,
          strictSetInference = true,
        },
      },
    },
  },
}
