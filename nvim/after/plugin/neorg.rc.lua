local neorg_ok, neorg = pcall(require, "neorg")
if (not neorg_ok) then return end

neorg.setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.completion"] = { 
            config = { 
                engine = "nvim-cmp" 
            } 
        },
        ["core.concealer"] = {
            config = {
                icon_preset = "diamond",
                folds = false,
                dim_code_blocks = {
                    enabled = false,
                    padding = { left = 4 },
                },
            },                   -- Allows for use of icons
        },
        ["core.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/workspace/notes"
                }
            }
        }
    },
}
