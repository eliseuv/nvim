return {
  -- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typst",
      })
    end,
  },

  -- LSP
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "tinymist",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        tinymist = {
          --- todo: these configuration from lspconfig maybe broken
          single_file_support = true,
          root_dir = function()
            return vim.fn.getcwd()
          end,
          --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
          settings = {
            outputPath = "$root/target/$dir/$name",
            exportPdf = "onDocumentHasTitle",
            formatterMode = "typstyle",
          },
        },
      },
    },
  },

  -- Typst preview
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
  },

  -- Typst vim
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  },
}
