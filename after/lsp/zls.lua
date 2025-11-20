return {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zon' },
  -- root_dir = util.root_pattern('zls.json', 'build.zig', '.git'),
  settings = {
    zig = {
      enable_build_on_save = true,
    },
  },
}
