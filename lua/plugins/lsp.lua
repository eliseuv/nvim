return {

  {
    "mason-org/mason.nvim",
    -- Disable mason
    enabled = false,
    opts = {
      -- Prefer local binaries over mason binaries
      PATH = "append",
    },
  },

  { "mason-org/mason-lspconfig.nvim", enabled = false },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if vim.fn.executable("vue-language-server") == 1 then
        local vue_ls_path = vim.fn.exepath("vue-language-server")
        local nix_store_path = vue_ls_path:match("(.*)/bin/vue%-language%-server")
        if nix_store_path then
          -- Reset globalPlugins to avoid duplicating the broken Mason entry added by LazyVim's vue extra
          opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins = {}

          table.insert(opts.servers.vtsls.filetypes, "vue")
          LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
            {
              name = "@vue/typescript-plugin",
              location = nix_store_path .. "/lib/language-tools/node_modules/.pnpm/node_modules/@vue/language-server",
              languages = { "vue" },
              configNamespace = "typescript",
              enableForWorkspaceTypeScriptVersions = true,
            },
          })
        end
      end
    end,
  },
}
