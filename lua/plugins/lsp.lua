return {

  {
    "mason-org/mason.nvim",
    -- Disable mason
    enabled = false,
    opts = {
      -- Prefer local binaries over mason binaries
      PATH = "append",
    },
  },

  { "mason-org/mason-lspconfig.nvim", enabled = false },
}
