{ pkgs, lib, config, ... }:

{
  xdg.configFile."kitty/themes/koda-mono.conf".source = ./themes/koda-mono.conf;
  xdg.configFile."kitty/themes/catppuccin-mocha.conf".source = ./themes/catppuccin-mocha.conf;

  programs.kitty = lib.mkForce {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
      size = 11;
    };

    settings = {
      # --- Font Rendering ---
      italic_font = "FiraCode Nerd Font Italic";
      bold_font = "FiraCode Nerd Font Bold";
      bold_italic_font = "FiraCode Nerd Font Bold Italic";
      adjust_line_height = 4;
      adjust_column_width = 1;

      # --- Window Behaviour ---
      window_padding_width = 3;
      enable_audio_bell = false;
      remember_window_size = false;
      hide_window_decorations = "titlebar-only";
      window_border_width = 0;
      confirm_os_window_close = 0;

      # --- Performance ---
      repaint_delay = 10;
      input_delay = 1;
      sync_to_monitor = "yes";

      # --- Scrollback ---
      scrollback_lines = 10000;
      scrollback_pager_history_size = 64;

      # --- Cursor behaviour ---
      cursor_shape = "block";
      cursor_blink_interval = "0.8";

      # --- Transparency ---
      background_opacity = "0.98";

      # --- Other ---
      shell_integration = "enabled";
    };

    extraConfig = ''
      # Default theme (F5/F6 toggle between themes at runtime)
      include themes/koda-mono.conf
    '';

    keybindings = {
      "ctrl+shift+enter" = "new_tab";
      "ctrl+shift+left"  = "previous_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+w"     = "close_tab";

      # Theme toggle keybind
      "f5" = "set_colors --configured --all ${config.xdg.configHome}/kitty/themes/catppuccin-mocha.conf";
      "f6" = "set_colors --configured --all ${config.xdg.configHome}/kitty/themes/koda-mono.conf";
    };
  };
}
