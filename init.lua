require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lsp'
require 'lazy_init'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
