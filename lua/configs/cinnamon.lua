local M = {}

function M.config()
  local status_ok, cinnamon = pcall(require, "cinnamon")
  if status_ok then
    cinnamon.setup(doomnvim.user_plugin_opts("plugins.cinnamon", {}))
  end
end

return M
