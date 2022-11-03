local status_ok, fidget = pcall(require, "copilot")
if not status_ok then
  return
end
vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true

vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")')
