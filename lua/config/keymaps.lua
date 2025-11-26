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
vim.keymap.set('n', '<leader>n', '<cmd> set rnu! <CR>', { desc = 'Toggle relative line numbers' })

-- Fix annoying issue of hover documentation floating window
-- not disappearing when jumping to a definition in another file.
-- default close_events does not have BufHidden.
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover { close_events = { 'CursorMoved', 'CursorMovedI', 'InsertCharPre', 'BufHidden' } }
end, { desc = 'LSP Hover Documentation' })
