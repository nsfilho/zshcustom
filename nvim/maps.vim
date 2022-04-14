nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <silent> <leader>] :BufferLineCycleNext<CR>
nnoremap <silent> <leader>[ :BufferLineCyclePrev<CR>
nnoremap <C-x> :bd<CR>

nnoremap <silent> <leader>w :set wrap! wrap?<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

" Navigate neovim + neovim terminal emulator with alt+direction
tnoremap <silent><C-h> <C-\><C-n><C-w>h
tnoremap <silent><C-j> <C-\><C-n><C-w>j
tnoremap <silent><C-k> <C-\><C-n><C-w>k
tnoremap <silent><C-l> <C-\><C-n><C-w>l

nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==

" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

nnoremap <F2> <cmd>Format<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>lua require("telescope.builtin").find_files({hidden = true})<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fn <cmd>Telescope file_browser<cr>

" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <silent> <leader>tg <cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR>
tnoremap <silent> <leader>tg <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

nnoremap <silent> <leader>tt <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <leader>tt <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

nnoremap <leader><esc> :noh<return>

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
" nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
" nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
" nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
" nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
" nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
" nnoremap <silent> <Leader>cn :DashboardNewFile<CR>
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

lua << EOF
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
map("n", "<F7>", ":NvimTreeRefresh<cr>:NvimTreeFindFile<cr>", { silent = true})
map("n", "<space>h", "<cmd>lua require'hop'.hint_words()<cr>")
map("n", "<space>l", "<cmd>lua require'hop'.hint_lines()<cr>")
map("v", "<space>h", "<cmd>lua require'hop'.hint_words()<cr>")
map("v", "<space>l", "<cmd>lua require'hop'.hint_lines()<cr>")
map("n", "<leader>cf", ":Lspsaga lsp_finder<CR>", { silent = true })
-- map("n", "<leader>ca", ":Lspsaga code_action<CR>", { silent = true })
-- map("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", { silent = true })
map("n", "K", ":Lspsaga hover_doc<CR>", { silent = true })
map("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { silent = true })
map("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { silent = true })
map("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
map("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "<leader>cn", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
map("n", "<leader>cp", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "<leader>cr", ":Lspsaga rename<CR>", { silent = true })
map("n", "<leader>cd", ":Lspsaga preview_definition<CR>", { silent = true })
EOF

