local navic = require("nvim-navic")

require('lualine').setup {
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
            { navic.get_location, cond = navic.is_available },
        },
    },
}
