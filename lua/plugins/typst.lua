return {
  -- Extends lazyvim.plugins.extras.lang.typst
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          -- vim.lsp.config signature: the root must be passed to `on_dir`;
          -- returning it (old lspconfig style) leaves the server unstarted.
          root_dir = function(_, on_dir)
            on_dir(vim.fn.getcwd())
          end,
          --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
          settings = {
            outputPath = "$root/target/$dir/$name",
            exportPdf = "onDocumentHasTitle",
          },
        },
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    version = "1.*",
  },
}
