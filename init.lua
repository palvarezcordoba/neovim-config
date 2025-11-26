require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lsp'
require 'lazy_init'

---@type vim.api.keyset.user_command
local make_cmd_opts = {
  nargs = '*',
  complete = function(arg_lead, _, _)
    local targets =
      vim.fn.systemlist "make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\\/\\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | grep -v Makefile | sort -u"
    return vim.tbl_filter(function(target)
      return target:match('^' .. arg_lead)
    end, targets)
  end,
}

--- Just like make, but with command-line completion for targets.
vim.api.nvim_create_user_command('Make', function(opts)
  local args = opts.fargs
  if #args == 0 then
    vim.cmd 'make'
  else
    local cmd = 'make ' .. table.concat(args, ' ')
    vim.cmd(cmd)
  end
end, make_cmd_opts)
