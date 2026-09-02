require("lualine").setup({
  options = {
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
      },
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
      },
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
