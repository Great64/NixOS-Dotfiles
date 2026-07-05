{ pkgs, config, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "${pkgs.kitty}/bin/kitty";

    extraConfig = {
      modi        = "combi";
      combi-modi  = "drun,run";
      show-icons  = true;
      icon-theme  = "Papirus-Dark";
      placeholder = "Search";
      drun-display-format = "{name}";
    };

    theme = {
      "*" = {
        background-color = mkLiteral "#000000";
        border-color     = mkLiteral "#3d3d3d";
        text-color       = mkLiteral "#e0e0e0";
        font             = "FiraCode Nerd Font 14";
      };

      "window" = {
        width            = mkLiteral "500px";
        background-color = mkLiteral "#000000";
        border           = mkLiteral "1px solid";
        border-color     = mkLiteral "#3d3d3d";
        border-radius    = mkLiteral "10px";
        padding          = mkLiteral "12px";
      };

      "mainbox" = {
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };

      "inputbar" = {
        children     = mkLiteral "[prompt, entry]";
        padding      = mkLiteral "8px 4px";
        border       = mkLiteral "0px 0px 1px 0px";
        border-color = mkLiteral "#3d3d3d";
        spacing      = mkLiteral "4px";
      };

      "prompt" = {
        text-color = mkLiteral "#a6a6a6";
        padding    = mkLiteral "0px 4px 0px 0px";
      };

      "entry" = {
        text-color        = mkLiteral "#e0e0e0";
        placeholder       = "Search";
        placeholder-color = mkLiteral "rgba(166, 166, 166, 0.4)";
      };

      "listview" = {
        border   = mkLiteral "0px";
        margin   = mkLiteral "8px 0px 0px 0px";
        columns  = mkLiteral "1";
        lines    = mkLiteral "8";
        spacing  = mkLiteral "2px";
      };

      "element" = {
        padding      = mkLiteral "6px 8px";
        border-radius = mkLiteral "6px";
        spacing      = mkLiteral "8px";
      };

      "element normal normal" = {
        background-color = mkLiteral "transparent";
        text-color       = mkLiteral "#e0e0e0";
      };

      "element normal urgent" = {
        text-color = mkLiteral "#a6a6a6";
      };

      "element selected normal" = {
        background-color = mkLiteral "#3d3d3d";
        text-color       = mkLiteral "#e0e0e0";
      };

      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color       = mkLiteral "inherit";
        vertical-align   = mkLiteral "0.5";
      };

      "element-icon" = {
        background-color = mkLiteral "transparent";
        size             = mkLiteral "16px";
      };

      "scrollbar" = {
        handle-color     = mkLiteral "#3d3d3d";
        background-color = mkLiteral "transparent";
        border-radius    = mkLiteral "4px";
        handle-width     = mkLiteral "4px";
        width            = mkLiteral "4px";
      };
    };
  };
}
