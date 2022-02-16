if has("unix")
  let g:arch = system("arch")
endif

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Mofiqul/vscode.nvim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'phaazon/hop.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/which-key.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
" Plug 'glepnir/dashboard-nvim'
Plug 'sbdchd/neoformat'

" Auto-complete plugins
Plug 'neovim/nvim-lspconfig'
" Plug 'kabouzeid/nvim-lspinstall'
Plug 'williamboman/nvim-lsp-installer'
" Plug 'glepnir/lspsaga.nvim'
Plug 'tami5/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-calc'
Plug 'f3fora/cmp-spell'
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'folke/lsp-colors.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

if g:arch == "x86_64" || g:arch == "i386"
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
endif

Plug 'editorconfig/editorconfig-vim'
call plug#end()
