local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Setup nvim-cmp
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-y>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

-- Custom on_attach function
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- Keymaps
    vim.keymap.set("n", "<leader>dc", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>dt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>n", function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    -- Diagnostics
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

-- Configure language servers
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})

lspconfig.ruff.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ruff = {
            lint = {
                enable = true,
            },
        },
    },
})

lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                diagnosticMode = "off",
                typeCheckingMode = "off",
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportGeneralTypeIssues = "none",
                    reportPropertyTypeMismatch = "none",
                    reportMissingImports = "none",
                    reportMissingTypeStubs = "none",
                    reportUndefinedVariable = "none",
                    reportUnboundVariable = "none",
                },
            },
        },
    },
    flags = {
        debounce_text_changes = 150,
    },
})


lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Enable border for LSP hover windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})
