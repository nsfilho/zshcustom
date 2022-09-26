vim.cmd("autocmd!")
vim.opt.termguicolors = true
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.mouse = 'a'
vim.wo.colorcolumn = "120"
vim.opt.hidden = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.hlsearch = true
vim.opt.signcolumn = 'yes'
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.ttyfast = true
vim.opt.wrap = false -- No Wrap lines
vim.opt.cmdheight = 1
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'zsh'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.breakindent = true
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }
vim.g.mapleader = ','
-- vim.opt.foldcolumn = '3'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.spelllang = { 'en', 'pt' }
vim.g.ayucolor="mirage"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = '*',
    callback = function()
        vim.cmd([[set relativenumber]])
        vim.cmd([[set nopaste]])
        vim.cmd([[set nocursorcolumn]])
    end
})
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = '*',
    callback = function()
        vim.cmd([[set norelativenumber]])
        vim.cmd([[set cursorcolumn]])
    end
})

local fileTypes = vim.api.nvim_create_augroup("filetypes", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.json",
    command = "set filetype=jsonc",
    group = fileTypes,
})
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = {
--         "yaml", "go", "rust", "java", "c", "typescript",
--         "javascript", "typescriptreact", "javascriptreact"
--     },
--     command = "setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldlevel=99",
--     group = fileTypes,
-- })

local terminalSplit = vim.api.nvim_create_augroup("terminalSplit", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "setlocal list",
    group = terminalSplit,
})
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
    pattern = "*",
    command = "startinsert",
    group = terminalSplit,
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }
