local status, packer = pcall(require, "packer")
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'folke/tokyonight.nvim',
        branch = 'main',
    }
    use 'kyazdani42/nvim-web-devicons' -- File icons
    use 'phaazon/hop.nvim'
    use 'nvim-lua/popup.nvim'
    use 'folke/which-key.nvim'
    use 'nvim-lua/plenary.nvim' -- Common utilities
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
    }
    use 'lewis6991/gitsigns.nvim'
    use 'kyazdani42/nvim-tree.lua'
    -- use 'folke/which-key.nvim'
    use 'nvim-lualine/lualine.nvim' -- Statusline
    use 'akinsho/bufferline.nvim'
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
    -- use 'folke/lsp-colors.nvim'
    use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    use 'numToStr/Comment.nvim'
    use 'SmiteshP/nvim-navic' -- show inside context in statusline
    use 'haringsrob/nvim_context_vt' -- show end tags

    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'norcalli/nvim-colorizer.lua' -- see colors #ffee00 in buffer
    use 'dinhhuy258/git.nvim' -- For git blame & browse

    if (vim.g.arch == 'i386' or vim.g.arch == 'x86_64') then
        use 'tpope/vim-dadbod'
        use 'kristijanhusak/vim-dadbod-completion'
        use 'kristijanhusak/vim-dadbod-ui'
        use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
    end
    -- use 'editorconfig/editorconfig-vim'

end)
