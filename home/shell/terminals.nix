{ pkgs, lib, ... }:

{
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

      # --- Styling - Koda Palette Dark Monochrome ---
      foreground = "#a6a6a6";
      background = "#080808";
      background_opacity = "0.98";

      selection_foreground = "#c4c4c4";
      selection_background = "#1a1a1a";

      cursor = "#c4c4c4";
      cursor_text_color = "#080808";
      cursor_shape = "block";
      cursor_blink_interval = "0.8";

      url_color = "#8a8a8a";
      active_border_color = "#1a1a1a";
      inactive_border_color = "#121212";

      # --- ANSI Colours (vertical) ---
      color0  = "#000000";
      color8  = "#3d3d3d";
      color1  = "#4a4a4a";
      color9  = "#686868";
      color2  = "#5c5c5c";
      color10 = "#a6a6a6";
      color3  = "#666666";
      color11 = "#b0b0b0";
      color4  = "#707070";
      color12 = "#b8b8b8";
      color5  = "#7a7a7a";
      color13 = "#d0d0d0";
      color6  = "#848484";
      color14 = "#c0c0c0";
      color7  = "#a6a6a6";
      color15 = "#e0e0e0";

      # --- Other ---
      shell_integration = "enabled";
    };
   
    keybindings = {
      "ctrl+shift+enter" = "new_tab";
      "ctrl+shift+left"  = "previous_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+w"     = "close_tab";
    };
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "tmux-256color";
    historyLimit = 10000;

    extraConfig = ''
      # --- Colours ---
      set -g status-style                 "bg=#080808,fg=#a6a6a6"
      set -g status-left                  ""
      set -g status-right                 ""
      set -g window-status-current-style  "fg=#e0e0e0,bold"
      set -g window-status-style          "fg=#3d3d3d"
      set -g pane-border-style            "fg=#3d3d3d"
      set -g pane-active-border-style     "fg=#a6a6a6"
      set -g message-style                "bg=#080808,fg=#a6a6a6"

      # --- Behaviour ---
      set -g base-index 1          # start window numbering at 1
      set -g renumber-windows on   # keep window numbers tidy
      set -sg escape-time 0        # no delay for escape key in nvim
    '';
  };
}
