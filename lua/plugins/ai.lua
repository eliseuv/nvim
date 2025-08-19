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
      "ravitemer/codecompanion-history.nvim",
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
      prompt_library = {
        ["Code Expert"] = {
          strategy = "chat",
          description = "Get some special advice from an LLM",
          opts = {
            mapping = "<leader>ce",
            modes = { "v" },
            short_name = "expert",
            auto_submit = true,
            stop_context_insertion = true,
            user_prompt = true,
          },
          prompts = {
            {
              role = "system",
              content = function(context)
                return "I want you to act as a senior "
                  .. context.filetype
                  .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
              end,
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
      display = { diff = { provider = "mini_diff" } },
      opts = { log_level = "DEBUG" },
      extensions = {
        history = {
          enabled = true,
        },
      },
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
