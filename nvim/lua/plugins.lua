local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use {
        'folke/tokyonight.nvim',
        branch = 'main',
    }
    use 'kyazdani42/nvim-web-devicons' -- File icons
    use 'phaazon/hop.nvim'
    use 'nvim-lua/popup.nvim'
    use 'folke/which-key.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
            }
        end
    }
    use 'rmagatti/auto-session'
    use 'nvim-lua/plenary.nvim' -- Common utilities
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'lewis6991/gitsigns.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim' -- Statusline
    -- use 'akinsho/bufferline.nvim'
    use 'neovim/nvim-lspconfig' -- LSP
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'glepnir/lspsaga.nvim' -- LSP UIs
    use 'onsails/lspkind-nvim' -- vscode-like pictograms
    use 'hrsh7th/nvim-cmp' -- Completion
    use 'hrsh7th/cmp-vsnip' -- Completion
    use 'hrsh7th/vim-vsnip' -- Completion
    use 'hrsh7th/cmp-path' -- Completion
    use 'hrsh7th/cmp-buffer' -- Completion
    use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-calc'
    use 'f3fora/cmp-spell'
    use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    use 'numToStr/Comment.nvim'
    use 'haringsrob/nvim_context_vt' -- show end tags

    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use "j-hui/fidget.nvim"
    use "github/copilot.vim"
    use "tpope/vim-fugitive"

    if (jit.arch == 'x64') then
        use { 'tzachar/cmp-tabnine', after = "nvim-cmp", run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
    end

    if packer_bootstrap then
        require('packer').sync()
    end
    -- use 'editorconfig/editorconfig-vim'

end)

require('impatient')
