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
                    "lua_ls",          -- Lua
                    "ruff", "pyright", -- Python
                    "ts_ls",           -- JavaScript
                    "html",            -- HTML
                    "cssls"            -- CSS
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
                    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
                    "hrsh7th/cmp-buffer",   -- Buffer completions
                    "hrsh7th/cmp-path",     -- Path completions
                },
            },
        },
        config = function()
        end,
    },
}
