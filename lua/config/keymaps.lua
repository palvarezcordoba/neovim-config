vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>td', '<cmd>tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Open [G]it [D]iff view' })
-- vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = '[G]it [G]ui' })
vim.keymap.set('n', 'gp', '<cmd> norm `[v`]<CR>')
vim.keymap.set('x', 'p', 'pgvy')
-- Save with C-s
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>')

-- TODO: fix this
-- vim.keymap.set({ 'n', 'v' }, '<leader>cp', function()
--   if vim.fn.mode() == 'V' then
--     local _, lnum, _ = vim.fn.getpos 'v'
--     vim.notify('Visual Line Mode Lnum: ' .. lnum)
--     local start_line = math.min(vim.fn.line "'<" - 1, lnum - 1)
--     local end_line = math.max(vim.fn.line "'>", lnum)
--     local path = vim.fn.expand '%' .. ':' .. start_line + 1 .. '-' .. end_line
--     vim.notify('Mode: ' .. vim.fn.mode())
--     vim.notify 'Visual Line Mode'
--     local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
--     local text = table.concat(lines, '\n')
--     vim.notify('Copied lines ' .. start_line + 1 .. ' to ' .. end_line .. ': ' .. text)
--     vim.notify('Path: ' .. path)
--     vim.notify('Final text to copy: ' .. path .. '\n' .. text)
--     vim.fn.setreg('+', path .. '\n' .. text)
--   else
--     local path = vim.fn.expand '%' .. ':' .. vim.fn.line '.'
--     vim.notify('Mode: ' .. vim.fn.mode())
--     local text = vim.fn.getline '.'
--     vim.fn.setreg('+', path .. '\n' .. text)
--   end
-- end, { desc = 'Copy quickfix-style location with line text' })

vim.keymap.set('n', '<leader>n', '<cmd> set rnu! <CR>', { desc = 'Toggle relative line numbers' })

-- Fix annoying issue of hover documentation floating window
-- not disappearing when jumping to a definition in another file.
-- default close_events does not have BufHidden.
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover { close_events = { 'CursorMoved', 'CursorMovedI', 'InsertCharPre', 'BufHidden' } }
end, { desc = 'LSP Hover Documentation' })
