return {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
          [vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy'] = true,
          [vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy'] = true,
          [vim.fn.stdpath 'data' .. '/lazy/telescope.nvim/lua/telescope'] = true,
          [vim.fn.stdpath 'data' .. '/lazy/telescope.nvim/lua/telescope/builtin'] = true,
          [vim.fn.stdpath 'data' .. '/lazy/lspconfig.nvim/lua/lspconfig'] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
