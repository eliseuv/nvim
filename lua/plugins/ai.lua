return {

  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        prompts = {
          -- Propose implementation
          implement = "Popose an implementation for {this}. Use the containing comments as instructions on the desired behavior. Also take into cosideration the overall project style and idiom.",
          -- Scientific writing
          scientific = "Assume this is scientific text. If needed, rewrite parts of {this} for grammar, spelling, clarity and style always mantaining the original meaning. If there is information that needs to be added let me know but do not add it yourself.",
        },
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle({ name = "gemini", focus = true })
        end,
        desc = "Sidekick Toggle Gemini",
      },
    },
  },
}
