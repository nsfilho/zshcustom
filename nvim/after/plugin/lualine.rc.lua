local status, lualine = pcall(require, "lualine")
if (not status) then return end

-- local statusNavic, navic = pcall(require, "nvim-navic")
--
-- if (statusNavic) then
--     lualine.setup {
--         options = {
--             theme = 'tokyonight'
--             -- theme = 'dracula'
--             -- theme = 'vscode'
--         },
--         sections = {
--             lualine_c = {
--                 {
--                     'filename',
--                     file_status = true,
--                     path = 1,
--                 },
--                 { navic.get_location, cond = navic.is_available },
--             },
--         },
--     }
-- else
lualine.setup {
    options = {
        theme = 'tokyonight'
        -- theme = 'dracula'
        -- theme = 'vscode'
    },
    sections = {
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
            },
            require('lsp-progress').progress,
        },
    },
}
-- end

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
    group = "lualine_augroup",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
})
