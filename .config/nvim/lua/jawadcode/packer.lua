-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use "Mofiqul/vscode.nvim"

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

    use "nvim-treesitter/playground"

    use "theprimeagen/harpoon"

    use "mbbill/undotree"

    use "tpope/vim-fugitive"

    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-cmdline" },
            { "L3MON4D3/LuaSnip" },     -- Required
        }
    }

    use "hrsh7th/cmp-cmdline"

    use "simrat39/rust-tools.nvim"

    use {
        "windwp/nvim-autopairs",
        config = function() require "nvim-autopairs".setup {} end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require "which-key".setup()
        end
    }

    use {
        "nvim-lualine/lualine.nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
            opt = true
        }
    }

    use "drybalka/tree-climber.nvim"

    use "HiPhish/rainbow-delimiters.nvim"
end)
