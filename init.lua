local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

vim.opt.rtp:append(vim.fn.stdpath "config" .. "/../doomnvim")

for _, source in ipairs {
  "core.utils",
  "core.options",
  "core.plugins",
  "core.autocmds",
  "core.mappings",
  "core.ui",
  "configs.which-key-register",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

doomnvim.conditional_func(doomnvim.user_plugin_opts("polish", nil, false))
