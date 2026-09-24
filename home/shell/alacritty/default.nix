{ config, lib, ... }:

{
  xdg.configFile."alacritty/themes/koda-mono.toml".source = ./themes/koda-mono.toml;

  programs.alacritty = lib.mkForce {
    enable = true;

    settings = {
      general.import = [ "${config.xdg.configHome}/alacritty/themes/koda-mono.toml" ];

      # --- Window ---
      window = {
        padding = { x = 3; y = 3; };
        opacity = 0.98;
        decorations = "none";
        dynamic_padding = false;
      };

      # --- Scrollback ---
      scrolling.history = 10000;

      # --- Font ---
      font = {
        size = 11;
        normal = { family = "FiraCode Nerd Font"; style = "Regular"; };
        bold = { family = "FiraCode Nerd Font"; style = "Bold"; };
        italic = { family = "FiraCode Nerd Font"; style = "Italic"; };
        bold_italic = { family = "FiraCode Nerd Font"; style = "Bold Italic"; };
      };

      # --- Cursor ---
      cursor = {
        style = { shape = "Block"; blinking = "On"; };
        blink_interval = 800;
      };

      # --- Bell ---
      bell.duration = 0;
    };
  };
}
