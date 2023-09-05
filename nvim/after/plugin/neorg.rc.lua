local neorg_ok, neorg = pcall(require, "neorg")
if (not neorg_ok) then return end

-- check if the directory ~/workspace/notes exists, if not create it
if (vim.fn.isdirectory(os.getenv("HOME") .. "/workspace/notes") == 0) then
    vim.fn.mkdir(os.getenv("HOME") .. "/workspace/notes", "p")
end

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
            },              -- Allows for use of icons
        },
        ["core.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    notes = "~/workspace/notes"
                },
                default_workspace = "notes"
            }
        }
    },
}
