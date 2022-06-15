local present, smart_splits = pcall(require, "smart-splits")
if present then
  smart_splits.setup(doomnvim.user_plugin_opts("plugins.smart-splits", {
    ignored_filetypes = {
      "nofile",
      "quickfix",
      "qf",
      "prompt",
    },
    ignored_buftypes = { "nofile" },
  }))
end
