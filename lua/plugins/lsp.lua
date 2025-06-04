return {

  {
    "williamboman/mason.nvim",
    -- Disable mason
    enabled = false,
    opts = {
      -- Prefer local binaries over mason binaries
      PATH = "append",
    },
  },
}
