local status_ok, notify = pcall(require, "notify")
if not status_ok then return end
notify.setup(doomnvim.user_plugin_opts("plugins.notify", { stages = "fade" }))
vim.notify = notify
