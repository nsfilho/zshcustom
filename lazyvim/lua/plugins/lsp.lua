-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      local cmp = require("cmp")
      opts.completion.completeopt = "menu,preview,menuone,noinsert,noselect"
      opts.mapping["<CR>"] = cmp.mapping.confirm({ select = false })
    end,
  },
  {
    "nvim-lspconfig",
    opts = {
        inlay_hints = { enabled = false },
        servers = {
            clangd = {
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
            },
        },
    }
  }
}
