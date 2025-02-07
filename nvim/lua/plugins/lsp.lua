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
                "lua_ls", -- Lua
                "ruff",   -- Python
                "pylsp",  -- Python
            },
            automatic_installation = true,
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
        },
    },
}
