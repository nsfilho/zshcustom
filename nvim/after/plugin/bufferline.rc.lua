require("bufferline").setup {
    options = {
        numbers = function(opts)
            return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
        end,
        diagnostics = "nvim_lsp",
        separator_style = "slant"
    }
}
