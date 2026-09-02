{ pkgs, ... }:

let
  luaFile = name: builtins.readFile (./lua + "/${name}.lua");
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;  # sets $EDITOR to nvim
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [ clang-tools ];

    plugins = with pkgs.vimPlugins; [
      # Themes
      tokyonight-nvim
      mellow-nvim

      # Dashboard
      { plugin = alpha-nvim;      type = "lua"; config = luaFile "alpha"; }

      # Telescope
      plenary-nvim
      { plugin = telescope-nvim;  type = "lua"; config = luaFile "telescope"; }

      # Autopairs
      { plugin = nvim-autopairs;  type = "lua"; config = luaFile "autopairs"; }

      # Tabout
      { plugin = tabout-nvim;     type = "lua"; config = luaFile "tabout"; }

      # Harpoon
      { plugin = harpoon;         type = "lua"; config = luaFile "harpoon"; }

      # Lualine
      { plugin = lualine-nvim;    type = "lua"; config = luaFile "lualine"; }

      # Noice dependencies
      nui-nvim
      nvim-notify

      # Lazygit
      { plugin = lazygit-nvim;    type = "lua"; config = luaFile "lazygit"; }

      # Noice
      { plugin = noice-nvim;      type = "lua"; config = luaFile "noice"; }

      # Completion
      luasnip
      cmp_luasnip
      cmp-nvim-lsp
      { plugin = nvim-cmp;        type = "lua"; config = luaFile "cmp"; }

      # LSP
      { plugin = nvim-lspconfig;  type = "lua"; config = luaFile "lsp"; }
    ];

    extraLuaConfig = luaFile "init";
  };
}
