return {
  -- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "html",
        "css",
        "scss",
        "javascript",
        "json",
        "typescript",
        "tsx",
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ast_grep = {},
        biome = {},
        html = {},
        cssls = {},
        css_variables = {},
      },
    },
  },
}
