local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup {
    options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        enforce_regular_tabs = true,
        show_tab_indicators = true,
        indicator = {
            style = 'underline',
        },
        offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "left" }
        },
    }
}
