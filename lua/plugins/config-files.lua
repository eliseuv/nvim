return {
  -- Tridactyl config file syntax
  { "tridactyl/vim-tridactyl" },

  -- -- kdl: cuddly document language
  -- { "imsnif/kdl.vim" },

  -- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "hyprlang",
      })
    end,
  },
}
