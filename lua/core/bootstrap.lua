doomnvim.initialize_packer()

local colorscheme = doomnvim.user_plugin_opts("colorscheme", nil, false)
vim.api.nvim_command(
  "colorscheme "
    .. (vim.tbl_contains(vim.fn.getcompletion("", "color"), colorscheme) and colorscheme or "default_theme")
)
