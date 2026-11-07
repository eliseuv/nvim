return {

  -- Justfile
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },

  -- Justfile grammar, shipped by nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "just" } },
  },
}
