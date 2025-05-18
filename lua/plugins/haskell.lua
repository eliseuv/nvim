return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^6",
    lazy = false, -- This plugin is already lazy
    keys = {
      -- Hoogle function signature
      {
        "<leader>hs",
        require("haskell-tools").hoogle.hoogle_signature,
        desc = "Hoogle Signature",
      },
      -- Toggle GHCi REPL for current package
      {
        "<leader>hr",
        require("haskell-tools").repl.toggle,
        desc = "GHCi REPL",
      },
      -- Toggle GHCi REPL for current buffer
      {
        "<leader>hb",
        function()
          require("haskell-tools").repl.toggle(vim.api.nvim_buf_get_name(0))
        end,
        desc = "Buffer GHCi REPL",
      },
      -- Close GHCi REPL
      {
        "<leader>hq",
        require("haskell-tools").repl.quit,
        desc = "Close GHCi REPL",
      },
    },
  },
}
