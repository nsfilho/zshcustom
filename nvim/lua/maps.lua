local keymap = vim.keymap

-- general mappings
keymap.set("i", "<C-c>", "<Esc>", { silent = true, remap = false }) -- facilitate exit from insert mode
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "J", "mzJ`z")

-- Split window
keymap.set('n', 'ss', ':split<Return>')
keymap.set('n', 'sv', ':vsplit<Return>')
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h', { remap = false })
keymap.set('', 'sk', '<C-w>k', { remap = false })
keymap.set('', 'sj', '<C-w>j', { remap = false })
keymap.set('', 'sl', '<C-w>l', { remap = false })
keymap.set('', 'sc', '<C-w>q', { remap = false })
keymap.set('', 'so', '<C-w>o', { remap = false })
keymap.set('', 'sw', ':set wrap!<Return>', { remap = false })
-- keymap.set('', 's=', ':vert resize +5<Return>', { silent = true, remap = false })
-- keymap.set('', 's-', ':vert resize -5<Return>', { silent = true, remap = false })

-- general maps
keymap.set('n', '<leader>xx', ':quitall<CR>')
keymap.set('n', '<leader>xc', ':bd!<CR>')
keymap.set('n', '<C-n>', function ()
    -- check if nvim-tree is opened
    local tree = require('nvim-tree.api')
    if tree.tree.is_visible() then
        tree.tree.close()
    else
        tree.tree.open({
            find_file = true,
        })
    end
end)
-- keymap.set('n', '<esc><esc>', ':noh<CR>')
keymap.set('n', ']b', ':BufferLineCycleNext<CR>');
keymap.set('n', '[b', ':BufferLineCyclePrev<CR>');
keymap.set('n', '<leader>ww', ':w<CR>', { remap = false })
keymap.set('n', '<leader>wa', ':wall<CR>', { remap = false })

-- Move window in terminal mode
keymap.set('n', '<leader>t', ':split <bar> :terminal<cr>')
keymap.set('t', '<C-d>', '<C-\\><C-n>')
-- keymap.set('t', '<C-x>', '<C-\\><C-n>:q!<CR>')

-- Move lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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
        -- require("telescope.builtin").git_files({ show_untracked = true, use_git_root = true, recurse_submodules = true, hidden = true })
        require("telescope.builtin").find_files()
    end
)
keymap.set('n', '<leader>fw', 'viw"zy:lua require("telescope.builtin").grep_string({ search = vim.fn.getreg("z") })<CR>')
keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
keymap.set('n', '<leader>fb', function()
    require('telescope.builtin').buffers({
        respect_gitignore = false,
        initial_mode = 'normal',
    })
end)
keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
keymap.set('n', '<leader>fr', '<cmd>Telescope registers<CR>')
keymap.set('n', '<leader>fn', function()
    require('telescope').extensions.file_browser.file_browser({
        grouped = true,
        previewer = false,
        hidden = true,
        respect_gitignore = false,
        initial_mode = 'normal',
        path = vim.fn.expand('%:p:h'),
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
