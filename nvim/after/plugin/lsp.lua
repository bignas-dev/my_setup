local lspconfig = require("lspconfig")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()


vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})


cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-y>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    }),
})

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

lspconfig.ruff.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "python" },
    init_options = {
        settings = {
            lint = {
                enable = false
            }
    }
}})

vim.lsp.config('ty', {
  settings = {
    ty = {
        experimental = {
            rename = true,
      },
    }
  }
})

vim.lsp.enable('ty')
