local status, session_manager = pcall(require, "session_manager")
if not status_ok then return end
session_manager.setup(doomnvim.user_plugin_opts("plugins.session_manager", {
  autoload_mode = "Disabled",
}))
