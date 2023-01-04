local status, navic = pcall(require, "nvim-navic")
if (not status) then return end

navic.setup()

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
