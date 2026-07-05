{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;  # sets $EDITOR to nvim
    viAlias = true;        
    vimAlias = true;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      # Themes
      tokyonight-nvim
      mellow-nvim

      # Dashboard
      {
        plugin = alpha-nvim;
        type = "lua";
        config = ''
          require("alpha").setup(require("alpha.themes.dashboard").config)
        '';
      }

      # Telescope
      plenary-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require("telescope").setup({})

          -- Keymaps
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
          vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live grep" })
          vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Buffers" })
          vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help tags" })
        '';
      }

      # Autopairs — must load before tabout
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup({})
        '';
      }

      # Tabout
      {
        plugin = tabout-nvim;
        type = "lua";
        config = ''
          require("tabout").setup({
            tabkey = "<Tab>",
            backwards_tabkey = "<S-Tab>",
            act_as_tab = true,
            completion = true,
          })
        '';
      }
     
      # Harpoon
      {
        plugin = harpoon;
        type = "lua";
        config = ''
          local mark = require("harpoon.mark")
          local ui   = require("harpoon.ui")

          vim.keymap.set("n", "<leader>ha", mark.add_file,        { desc = "Harpoon add file" })
          vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = "Harpoon menu" })
          vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, { desc = "Harpoon file 1" })
          vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end, { desc = "Harpoon file 2" })
          vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, { desc = "Harpoon file 3" })
          vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end, { desc = "Harpoon file 4" })
        '';
      }

      # Lualine
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
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
        '';
      }

      # Noice dependencies
      nui-nvim
      nvim-notify

      # Lazygit
      {
        plugin = lazygit-nvim;
        type = "lua";
        config = ''
          vim.g.lazygit_floating_window_use_plenary = 0
          vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
        '';
      }

      # Noice
      {
        plugin = noice-nvim;
        type = "lua";
        config = ''
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
        '';
      }
    ];

    extraLuaConfig = ''
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
    '';       
  };
}
