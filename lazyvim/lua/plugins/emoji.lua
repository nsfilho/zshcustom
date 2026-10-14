return {
  "saghen/blink.cmp",
  dependencies = {
    "moyiz/blink-emoji.nvim",
  },
  opts = {
    sources = {
      -- "enabled" ADICIONA o source emoji mantendo a lista padrão
      -- (lsp, path, buffer, ...). "default = {...}" SUBSTITUIRIA a lista
      -- — e "..." em Lua é vararg vazio, não spread, como sugere o README.
      enabled = {
        emoji = true,
      },
      providers = {
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = {
            insert = true, -- Insert emoji (default) or complete its name
            ---@type string|table|fun():table
            trigger = function()
              return { ":" }
            end,
          },
          should_show_items = function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
              { "gitcommit", "markdown" },
              vim.o.filetype
            )
          end,
        },
      },
    },
  },
}
