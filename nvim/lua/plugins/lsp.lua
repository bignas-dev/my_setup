return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", -- Lua
                    "ruff",   -- Python linting/formatting
                    "ty",     -- Python type checking
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-path",
                },
            },
        },
        config = function()
            -- Your existing LSP config goes here
        end,
    },
    {
        "aekasitt/tylsp.nvim",
        ft = "python",
        config = function()
            require("tylsp").setup({
                -- Optional: customize ty settings
                settings = {
                    ty = {
                        -- Add any ty-specific settings here
                    }
                }
            })
        end,
    },
}
