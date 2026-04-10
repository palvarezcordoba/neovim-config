local function get_version(package_name)
  local output = vim.fn.systemlist({ "pip", "show", package_name })

  if vim.v.shell_error ~= 0 or not output then
    return nil, "pip show failed for package: " .. package_name
  end

  for _, line in ipairs(output) do
    local version = line:match("^Version:%s*(.+)$")
    if version and version ~= "" then
      return version, nil
    end
  end

  return nil, "Version not found for package: " .. package_name
end

local function sync_current_line()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]

  if not line then
    vim.notify("No line under cursor", vim.log.levels.ERROR)
    return
  end

  local left, quote, _spec, right_quote, suffix = line:match(
    "^(%s*[%w%._%-]+%s*=%s*)([\"'])(.-)([\"'])(.*)$"
  )

  if not left or not quote or not right_quote then
    vim.notify("Line must look like: package = \"version spec\"", vim.log.levels.ERROR)
    return
  end

  if quote ~= right_quote then
    vim.notify("Mismatched quotes in dependency line", vim.log.levels.ERROR)
    return
  end

  local package_name = left:match("^%s*([%w%._%-]+)%s*=")
  if not package_name then
    vim.notify("Could not parse package name", vim.log.levels.ERROR)
    return
  end

  local version, err = get_version(package_name)
  if not version then
    vim.notify(err, vim.log.levels.ERROR)
    return
  end

  local new_line = string.format("%s%s==%s%s%s", left, quote, version, quote, suffix)
  vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
  vim.notify(string.format("%s -> ==%s", package_name, version), vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("SyncPinnedVersion", sync_current_line, {
  desc = "Replace current dependency spec with ==<installed pip version>",
})

return {
  sync_current_line = sync_current_line,
}
