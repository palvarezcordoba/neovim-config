vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_augroup('yank_restore_cursor', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'CursorMoved' }, {
  group = 'yank_restore_cursor',
  callback = function()
    local cursor = vim.fn.getpos '.'
    vim.api.nvim_create_autocmd('TextYankPost', {
      group = 'yank_restore_cursor',
      once = true,
      callback = function()
        if vim.v.event.operator == 'y' then
          vim.fn.setpos('.', cursor)
        end
      end,
    })
  end,
})
