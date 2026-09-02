require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  presets = {
    bottom_search = true,        -- classic bottom cmdline for search
    command_palette = true,      -- cmdline and popupmenu together
    long_message_to_split = true,
    lsp_doc_border = false,
  },
})

-- Keymaps
vim.keymap.set("n", "<leader>nl", function() require("noice").cmd("last") end,    { desc = "Noice last message" })
vim.keymap.set("n", "<leader>nh", function() require("noice").cmd("history") end, { desc = "Noice history" })
vim.keymap.set("n", "<leader>nd", function() require("noice").cmd("dismiss") end, { desc = "Noice dismiss" })
