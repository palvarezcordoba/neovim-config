-- vim: ts=2 sts=2 sw=2 et

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local keymaps = {
  n = {
    { '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' } },
    { '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { desc = 'Open diagnostic [Q]uickfix list' } },
    { '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' } },
    { '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' } },
    { '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' } },
    { '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' } },
    { '<C-s>', '<cmd> w <CR>', { desc = 'Save file' } },
  },
  t = {
    -- TODO
    -- { '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }}
    { '<Esc>', '<C-\\><C-N>' },
    -- TODO
    -- { '', '<C-\\>' },
    { '<Esc><Esc>', '<C-\\><Esc>' },
  },
}

for mode, mappings in pairs(keymaps) do
  for _, mapping in ipairs(mappings) do
    local lhs = mapping[1]
    local rhs = mapping[2]
    local opts = mapping[3] or {}
    map(mode, lhs, rhs, opts)
  end
end
