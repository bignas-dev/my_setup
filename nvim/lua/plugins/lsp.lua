return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",                  -- Lua
                "clangd",                  -- C/C++
                "ruff",                    -- Python Linting
                "pyright",                 -- Python Navigation
                "bashls",                  -- Bash
                "jsonls",                  -- JSON
                "yamlls",                  -- YAML
            },
            automatic_installation = true, -- Automatically install LSPs
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",             -- Autocompletion
            "hrsh7th/cmp-nvim-lsp",         -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",           -- Buffer completions
            "hrsh7th/cmp-path",             -- Path completions
            "L3MON4D3/LuaSnip",             -- Snippet engine
            "saadparwaiz1/cmp_luasnip",     -- Snippets source for nvim-cmp
            "rafamadriz/friendly-snippets", -- Snippet collection
            "j-hui/fidget.nvim",            -- LSP progress UI
            "folke/neodev.nvim",            -- Better Lua development
        },
        config = function()
        end,
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {
            text = {
                spinner = "dots", -- Animation style
            },
            window = {
                blend = 0, -- Fully opaque
            },
        },
    },
    {
        "folke/neodev.nvim",
        opts = {},
    },
}
