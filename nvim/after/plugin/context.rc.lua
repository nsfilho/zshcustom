local status, context = pcall(require, "nvim_context_vt")
if (not status) then return end

context.setup()
