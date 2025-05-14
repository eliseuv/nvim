return {

  -- LSP
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        uiua = {},
      },
    },
  },

  -- Syntax highlighting
  { "Apeiros-46B/uiua.vim" },
}
