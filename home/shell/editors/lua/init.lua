-- Keymaps
vim.g.mapleader = " "

-- Options
vim.opt.fillchars = {
  vert  = " ",
  horiz = " ",
  eob   = " ",
}

vim.opt.ruler = false   -- hide ruler
vim.g.netrw_banner = 0
vim.opt.nu = true       -- show line numbers

-- Set four spaces for indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true  -- converts any tab keys to spaces

vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.ignorecase = true  -- ignores case if all lower
vim.opt.smartcase = true   -- case sensitive if contains upper

vim.opt.clipboard:append("unnamedplus")  -- use system clipboard
vim.opt.signcolumn = "yes"
vim.o.cmdheight = 0
vim.opt.shortmess:append("sIcFW")

-- Colorscheme (defer until after all plugins load)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- require("tokyonight").setup({ style = "night" })
    vim.cmd("colorscheme mellow")
    vim.api.nvim_set_hl(0, "Normal",      { fg = "#c9b99a", bg = "#080808" })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#c9b99a", bg = "#080808" })
    vim.api.nvim_set_hl(0, "NormalNC",    { fg = "#c9b99a", bg = "#080808" })
  end,
})
