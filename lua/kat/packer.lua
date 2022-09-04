vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'monkoose/matchparen.nvim'
    use 'smithbm2316/centerpad.nvim'
    use 'tanvirtin/monokai.nvim'
    use 'folke/tokyonight.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'numToStr/Comment.nvim'
    use 'L3MON4D3/LuaSnip'
    use {
        'hrsh7th/cmp-cmdline',
        config = function ()
            require('Comment').setup()
        end
    }
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires =  {'nvim-lua/plenary.nvim'}
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                HACK = { icon = "🙈 ", color = "warning" }
            }
        end
    }
end)

