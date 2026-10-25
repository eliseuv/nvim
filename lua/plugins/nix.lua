return {
  -- Replaces the nil_ls server enabled by lazyvim.plugins.extras.lang.nix
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {},
        nil_ls = { enabled = false },
      },
    },
  },
}
