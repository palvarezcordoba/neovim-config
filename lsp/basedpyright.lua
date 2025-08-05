local uv = vim.loop

local function join_path(...)
  return table.concat({ ... }, '/')
end

local function is_dir(path)
  ---@diagnostic disable-next-line: undefined-field
  local stat = uv.fs_stat(path)
  return stat and stat.type == 'directory'
end

local function find_venv_dir()
  ---@diagnostic disable-next-line: undefined-field
  local dir = uv.cwd()
  while dir do
    local candidate = join_path(dir, '.venv')
    if is_dir(candidate) then
      candidate = join_path(candidate, 'bin', 'python')
      return candidate
    end

    local parent = join_path(dir, '..')
    ---@diagnostic disable-next-line: undefined-field
    local real_parent = uv.fs_realpath(parent)
    if not real_parent or real_parent == dir then
      break
    end
    dir = real_parent
  end

  return nil
end

return {
  settings = {
    basedpyright = {
      -- openFilesOnly = false,
      disableOrganizeImports = true,
      analysis = {
        diagnosticMode = 'openFilesOnly',
        -- diagnosticMode = 'workspace',
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
    python = {
      -- pythonPath = vim.fn.getcwd() .. '/.venv/bin/python',
      pythonPath = find_venv_dir(),
    },
  },
}
