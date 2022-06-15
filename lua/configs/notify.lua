local present, notify = pcall(require, "notify")
if present then
  notify.setup(doomnvim.user_plugin_opts("plugins.notify", { stages = "fade" }))

  vim.notify = notify
end
