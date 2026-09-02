{ ... }: {
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
