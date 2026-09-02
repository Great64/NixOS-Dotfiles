local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").clangd.setup({ capabilities = capabilities })

vim.keymap.set("n", "gd",         vim.lsp.buf.definition,   { desc = "Go to definition" })
vim.keymap.set("n", "K",          vim.lsp.buf.hover,        { desc = "Hover docs" })
vim.keymap.set("n", "gr",         vim.lsp.buf.references,   { desc = "References" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,       { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,  { desc = "Code action" })
vim.keymap.set("n", "<leader>e",  vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d",         vim.diagnostic.goto_next, { desc = "Next diagnostic" })
