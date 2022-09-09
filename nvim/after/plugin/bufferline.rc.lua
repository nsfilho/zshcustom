require("bufferline").setup {
    options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        enforce_regular_tabs = true,
        offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "left" }
        },
    }
}
