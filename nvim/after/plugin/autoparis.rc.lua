local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

autopairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
    disable_in_macro = true,
    enable_check_bracket_line = false,
    ignored_next_char = "[%w%.]",
})
