local status, lualine = pcall(require, "lualine")
if (not status) then return end

local statusNavic, navic = pcall(require, "nvim-navic")

if (statusNavic) then
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
                { navic.get_location, cond = navic.is_available },
            },
        },
    }
else
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
            },
        },
    }
end
