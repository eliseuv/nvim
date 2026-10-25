return {
  -- Extends lazyvim.plugins.extras.lang.typescript and its biome/vue siblings
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "scss" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ast_grep = {},
        html = {},
        cssls = {},
        css_variables = {},
      },
    },
  },
}
