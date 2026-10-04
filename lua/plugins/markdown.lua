return {
  -- Disable in favor of peek.nvim (browser-based preview, needs yarn/node;
  -- peek.nvim uses deno and renders in-window instead).
  { "iamcco/markdown-preview.nvim", enabled = false },

  -- Preview
  {
    "toppair/peek.nvim",
    ft = "markdown",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>cp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        ft = "markdown",
        desc = "Markdown Preview",
      },
    },
    opts = {},
  },

  -- Re-enable checkbox icons: disabled by LazyVim's markdown extra by
  -- default, but wanted here to pair with autolist.nvim's checkbox toggling.
  -- LaTeX rendering is off because `$…$` is typst here (see
  -- queries/markdown_inline/injections.scm), rendered by snacks.image instead.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      checkbox = {
        enabled = true,
      },
      latex = {
        enabled = false,
      },
    },
  },

  -- Inline images and typst math rendering (kitty graphics protocol).
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
      },
    },
  },

  -- List editing: auto-continue/renumber bullets and numbers, toggle checkboxes.
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown" },
    config = function()
      require("autolist").setup()
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", { buffer = true })
      vim.keymap.set("i", "<Tab>", "<cmd>AutolistTab<cr>", { buffer = true })
      vim.keymap.set("i", "<S-Tab>", "<cmd>AutolistShiftTab<cr>", { buffer = true })
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", { buffer = true })
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", { buffer = true })
      vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>", { buffer = true })
      vim.keymap.set("n", "<leader>mc", "<cmd>AutolistToggleCheckbox<cr>", { buffer = true, desc = "Toggle Checkbox" })
    end,
  },

  -- Table editing: auto-align pipes while typing.
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    init = function()
      -- Disable the plugin's own <leader>tm default mapping; define our own below.
      vim.g.table_mode_no_mappings = 1
    end,
    keys = {
      { "<leader>mt", "<cmd>TableModeToggle<cr>", ft = "markdown", desc = "Toggle Table Mode" },
    },
  },
}
