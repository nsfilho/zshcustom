return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Desabilitar inlay hints por padrão
      if not opts.inlay_hints then
        opts.inlay_hints = {}
      end
      opts.inlay_hints.enabled = false

      -- Desabilitar o `.git` para determinar o root_dir do vtsls
      -- (pois quando existe submodules, ele não le o tsconfig.json do diretorio pai -- raiz do projeto)
      opts.servers = opts.servers or {}
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, "package.json") or vim.fn.getcwd()
          on_dir(root)
        end,
      })
      return opts
    end,
  },
}
