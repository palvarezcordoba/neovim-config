return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = { preset = 'enter' },
    appearance = {
      nerd_font_variant = 'normal',
    },
    completion = { documentation = { auto_show = true } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    cmdline = {
      enabled = false,
    },
    fuzzy = { implementation = 'rust' },
    signature = { enabled = true },
  },
  opts_extend = { 'sources.default' },
}
