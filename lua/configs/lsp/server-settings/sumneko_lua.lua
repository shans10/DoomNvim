return {
  on_attach = doomnvim.lsp.disable_formatting,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [doomnvim.install.home .. "/lua"] = true,
          [doomnvim.install.config .. "/lua"] = true,
        },
      },
    },
  },
}
