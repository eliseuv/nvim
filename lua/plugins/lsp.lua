return {

  {
    "williamboman/mason.nvim",
    -- Disable mason
    enabled = false,
    -- Pin version
    version = "^1.0.0",
    -- enabled = false,
    opts = {
      -- Prefer local binaries over mason binaries
      PATH = "append",
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    -- Pin version
    version = "^1.0.0",
  },
}
