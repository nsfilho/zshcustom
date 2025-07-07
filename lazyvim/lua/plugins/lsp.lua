return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Desabilitar inlay hints por padrão
      if not opts.inlay_hints then
        opts.inlay_hints = {}
      end
      opts.inlay_hints.enabled = false
      return opts
    end,
  },
}
