local keymap = vim.keymap

-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h', { remap = false })
keymap.set('', 'sk', '<C-w>k', { remap = false })
keymap.set('', 'sj', '<C-w>j', { remap = false })
keymap.set('', 'sl', '<C-w>l', { remap = false })
keymap.set('', 'sc', '<C-w>q', { remap = false })
keymap.set('', 'so', '<C-w>o', { remap = false })

-- general maps
keymap.set('n', '<leader>xx', ':quitall<CR>')
keymap.set('n', '<leader>xc', ':bd!<CR>')
keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
keymap.set("n", "<F7>", ":NvimTreeRefresh<cr>:NvimTreeFindFile<cr>", { silent = true })
keymap.set('n', '<esc><esc>', ':noh<CR>')
keymap.set('n', ']b', ':BufferLineCycleNext<CR>');
keymap.set('n', '[b', ':BufferLineCyclePrev<CR>');
keymap.set('n', '<leader>ww', ':w<CR>', { remap = false })
keymap.set('n', '<leader>wa', ':wall<CR>', { remap = false })

-- Move window in terminal mode
keymap.set('n', '<leader>t', ':split <bar> :terminal<cr>')
keymap.set('t', 'sh', '<C-\\><C-n><C-w>h')
keymap.set('t', 'sk', '<C-\\><C-n><C-w>k')
keymap.set('t', 'sj', '<C-\\><C-n><C-w>j')
keymap.set('t', 'sl', '<C-\\><C-n><C-w>l')
keymap.set('t', '<C-x>', '<C-\\><C-n>:q!<CR>')

-- Move lines
keymap.set('n', '<A-Down>', ':m .+1<CR>==')
keymap.set('n', '<A-Up>', ':m .-2<CR>==')

-- Ident blocks
keymap.set('n', '>', '>gv')
keymap.set('n', '<', '<gv')

-- git signs
keymap.set('n', '<leader>sn', '<cmd>Gitsigns next_hunk<cr>')
keymap.set('n', '<leader>sp', '<cmd>Gitsigns prev_hunk<cr>')
keymap.set('n', '<leader>ss', '<cmd>Gitsigns preview_hunk<cr>')

-- telescope
keymap.set('n', '<leader>ff',
    function()
        require("telescope.builtin").find_files({ hidden = true })
    end
)
keymap.set('n', '<leader>fs', '<cmd>Telescope session-lens search_session<CR>')
keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
keymap.set('n', '<leader>fr', '<cmd>Telescope registers<CR>')
keymap.set('n', '<leader>fn', function()
    require('telescope').extensions.file_browser.file_browser({
        grouped = true,
        previewer = false,
        hidden = true,
        respect_gitignore = false,
        initial_mode = 'normal',
    })
end)

-- snippets plugin
-- keymap.set('i', 'expr', '<C-l>',
--     'vsnip#available(1) ? \'<Plug>(vsnip-expand-or-jump)\' : \'<C-l>\'')
-- keymap.set('s', 'expr', '<C-l>',
--     'vsnip#available(1) ? \'<Plug>(vsnip-expand-or-jump)\' : \'<C-l>\'')

-- hop plugin
keymap.set("n", "<space>h", "<cmd>lua require'hop'.hint_words()<cr>")
keymap.set("v", "<space>h", "<cmd>lua require'hop'.hint_words()<cr>")
keymap.set("n", "<space>l", "<cmd>lua require'hop'.hint_lines()<cr>")
keymap.set("v", "<space>l", "<cmd>lua require'hop'.hint_lines()<cr>")


-- maps for lsp
keymap.set("n", "<leader>cf", ":Lspsaga lsp_finder<CR>", { silent = true })
-- keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>", { silent = true })
-- keymap.set("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", { silent = true })
keymap.set("n", "K", ":Lspsaga hover_doc<CR>", { silent = true })
keymap.set("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { silent = true })
keymap.set("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { silent = true })
keymap.set("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
keymap.set("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
keymap.set("n", "<leader>cn", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap.set("n", "<leader>cp", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap.set("n", "<leader>cr", ":Lspsaga rename<CR>", { silent = true })
keymap.set("n", "<leader>cd", ":Lspsaga preview_definition<CR>", { silent = true })
