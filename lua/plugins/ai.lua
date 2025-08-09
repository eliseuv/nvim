return {

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
      },
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    opts = {
      ---@module "codecompanion"
      ---@type CodeCompanion.Config
      strategies = {
        inline = { adapter = { name = "gemini", model = "gemini-2.5-flash-preview-05-20" } },
        chat = {
          adapter = { name = "gemini", model = "gemini-2.5-flash-preview-05-20" },
          keymaps = {
            send = { modes = { i = { "<C-CR>", "<C-s>" } } },
            completion = { modes = {
              i = "<C-x>",
            } },
          },
        },
      },
      display = { diff = { provider = "mini_diff" } },
      opts = { log_level = "DEBUG" },
    },
    keys = {
      {
        "<leader>ag",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Open the action palette",
        mode = { "n", "v" },
      },
      {
        "<leader>aa",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Toggle a chat buffer",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add code to a chat buffer",
        mode = { "v" },
      },
    },
  },
}
