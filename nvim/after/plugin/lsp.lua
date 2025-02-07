local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("luasnip.loaders.from_vscode").lazy_load()

-- Keymaps
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

-- Keymaps
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>dc", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>dt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>n", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

-- Lua Setup (lua_ls - all)
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
        },
    },
})

-- Python Setup (ruff - format, pylsp - autocomplete)
lspconfig.ruff.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
    end,
    settings = {
        ruff = {
            lint = { enable = true },
        },
    },
})


lspconfig.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 100,
    },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = true },
                mccabe = { enabled = false },
                pydocstyle = { enabled = false },
                pylsp_mypy = { enabled = true, live_mode = true },
                pylsp_black = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                rope_completion = { enabled = true },
            },
        },
    },
})
