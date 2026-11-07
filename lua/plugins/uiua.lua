return {

  -- LSP
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        uiua = {},
      },
    },
  },

  -- Syntax highlighting
  { "Apeiros-46B/uiua.vim" },
}
