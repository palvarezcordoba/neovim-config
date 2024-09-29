-- vim: ts=2 sts=2 sw=2 et

vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'
require 'options'
require 'keymaps'
require 'auto_commands'
require 'lazy-bootstrap'
require 'lazy-setup'
dofile(vim.g.base46_cache .. 'defaults')
dofile(vim.g.base46_cache .. 'statusline')
