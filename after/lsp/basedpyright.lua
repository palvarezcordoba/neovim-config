---@param ... string
local function join_path(...)
  return table.concat({ ... }, '/')
end

local function find_venv_dir()
  local dir = vim.uv.cwd()
  while dir do
    local candidate = join_path(dir, '.venv', 'bin', 'python')
    if vim.uv.fs_stat(candidate) then
      return candidate
    end

    local parent = join_path(dir, '..')
    local real_parent = vim.uv.fs_realpath(parent)
    if not real_parent or real_parent == dir then
      break
    end
    dir = real_parent
  end

  return nil
end

---@param _ lsp.ResponseError?
---@param params lsp.PublishDiagnosticsParams
---@param ctx lsp.HandlerContext
local function on_publish_diagnostics(_, params, ctx)
  -- filter out params.diagnostics with a message that starts with "Baselined: "
  ---@type lsp.Diagnostic[]
  local diagnostics = {}
  for _, diag in ipairs(params.diagnostics) do
    if not vim.startswith(diag.message, 'Baselined: ') then
      table.insert(diagnostics, diag)
    end
  end

  -- if there are multiple diagnostics in the same line, keep only the one with the highest severity
  -- This is to improve the signal-to-noise ratio, and also to improve the "go to next/previous diagnostic" experience
  -- A lower severity value means a higher severity
  --- TODO: I should support multiple diagnostics per line, as long as they have the same severity.
  --- So, keeping all diagnostics of the highest severity per line instead.
  ---@type table<number, lsp.Diagnostic>
  local per_line_diagnostics = {}
  for _, diag in ipairs(diagnostics) do
    local line = diag.range.start.line
    if not per_line_diagnostics[line] or diag.severity < per_line_diagnostics[line].severity then
      per_line_diagnostics[line] = diag
    end
  end

  diagnostics = vim.tbl_values(per_line_diagnostics)
  params.diagnostics = diagnostics
  vim.lsp.diagnostic.on_publish_diagnostics(_, params, ctx)
end

--- Override for window/showMessageRequest to transform
--- messages without actions into simple notifications.
---@param error lsp.ResponseError?
---@param result lsp.ShowMessageRequestParams
---@param ctx lsp.HandlerContext
local function on_show_message_request(error, result, ctx)
  local severity_map = {
    [vim.lsp.protocol.MessageType.Error] = vim.log.levels.ERROR,
    [vim.lsp.protocol.MessageType.Warning] = vim.log.levels.WARN,
    [vim.lsp.protocol.MessageType.Info] = vim.log.levels.INFO,
    [vim.lsp.protocol.MessageType.Log] = vim.log.levels.DEBUG,
  }
  if result.actions == nil or vim.tbl_isempty(result.actions) then
    local notify = require('mini.notify').make_notify()
    notify(result.message, severity_map[result.type] or vim.log.levels.INFO)
    return vim.NIL
  end
  return vim.lsp.handlers['window/showMessageRequest'](error, result, ctx)
end

return {
  handlers = {
    ['textDocument/publishDiagnostics'] = on_publish_diagnostics,
    ['window/showMessageRequest'] = on_show_message_request,
  },
  ---@param client vim.lsp.Client
  ---@param bufnr number
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightWriteBaseLine', function()
      local params = {
        command = 'basedpyright.writeBaseline',
      }
      ---@diagnostic disable-next-line: param-type-mismatch
      client.request('workspace/executeCommand', params, nil, bufnr)
    end, {
      desc = 'Write Pyright Baseline for current workspace',
    })
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightLint', function()
      local Job = require 'plenary.job'
      local dir = join_path(client.root_dir, 'src')
      local cmd = { 'uvx', 'basedpyright', dir }

      local progress = require 'fidget.progress'
      local handle = progress.handle.create {
        title = 'basedpyright lint',
        message = 'Linting with basedpyright...',
        lsp_client = { name = 'basedpyright_lint' },
      }
      local output = {}
      local function on_new_line(line)
        table.insert(output, line)
        handle.message = table.concat(vim.list_slice(output, math.max(#output - 5, 1)), '\n')
      end
      Job:new({
        command = cmd[1],
        args = vim.list_slice(cmd, 2),
        on_stdout = function(_, line)
          on_new_line(line)
        end,
        on_stderr = function(_, line)
          on_new_line(line)
        end,
        on_exit = function(_, return_val)
          if return_val == 0 then
            local notify = require('mini.notify').make_notify()
            notify('basedpyright lint succeeded', vim.log.levels.INFO, { title = 'basedpyright' })
            handle:finish()
            return
          end
          handle:finish()
          vim.fn.setqflist({}, ' ', { title = 'basedpyright', lines = output })
          vim.cmd 'copen'
        end,
      }):start()
    end, {
      desc = 'Lint with basedpyright',
    })
  end,
  settings = {
    basedpyright = {
      openFilesOnly = true,
      disableOrganizeImports = true,
      analysis = {
        diagnosticMode = 'openFilesOnly',
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
      pythonPath = find_venv_dir(),
    },
  },
}
