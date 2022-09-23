local status, tree = pcall(require, "nvim-tree")
if (not status) then return end

tree.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open         = {
        cmd  = nil,
        args = {}
    },
    view                = {
        width = 30,
        -- height = 30,
        side = 'left',
        mappings = {
            custom_only = false,
            list = {}
        }
    }
}
