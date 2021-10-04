
require('lualine').setup {
    options = {
        -- theme = 'dracula'
        theme = 'vscode'
    },
    sections = {
        lualine_c = { {
            'filename',
            file_status = true,
            path = 1,
        } }
    }
}

