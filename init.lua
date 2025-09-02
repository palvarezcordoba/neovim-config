require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lsp'
require 'lazy_init'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.opt.clipboard = 'unnamedplus'
-- vim.g.clipboard = {
--   name = 'win32yank-wsl',
--   copy = {
--     ['+'] = 'win32yank -i --crlf',
--     ['*'] = 'win32yank -i --crlf',
--   },
--   paste = {
--     ['+'] = 'win32yank -o --lf',
--     ['*'] = 'win32yank -o --lf',
--   },
--   cache_enabled = true,
-- }
vim.schedule(function()
  -- vim.g.clipboard = {
  --   name = 'WslClipboard',
  --   copy = {
  --     ['+'] = 'clip.exe',
  --     ['*'] = 'clip.exe',
  --   },
  --   paste = {
  --     ['+'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  --     ['*'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  --   },
  --   cache_enabled = 0,
  -- }
end)

vim.cmd [[
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
]]
