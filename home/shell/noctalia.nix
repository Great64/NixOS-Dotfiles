{ inputs, config, ... }:

let
  enable = true;
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  xdg.configFile."noctalia/palettes/Monochrome.json".text = builtins.toJSON {
    dark = {
      mPrimary          = "#c4c4c4";
      mOnPrimary        = "#080808";
      mSecondary        = "#a6a6a6";
      mOnSecondary      = "#080808";
      mTertiary         = "#a6a6a6";
      mOnTertiary       = "#080808";
      mError            = "#a6a6a6";
      mOnError          = "#080808";
      mSurface          = "#080808";
      mOnSurface        = "#a6a6a6";
      mSurfaceVariant   = "#1a1a1a";
      mOnSurfaceVariant = "#a6a6a6";
      mOutline          = "#3d3d3d";
      mShadow           = "#000000";
      mHover            = "#1a1a1a";
      mOnHover          = "#c4c4c4";
      terminal = {
        background  = "#080808";
        foreground  = "#a6a6a6";
        cursor      = "#c4c4c4";
        cursorText  = "#080808";
        selectionBg = "#1a1a1a";
        selectionFg = "#c4c4c4";
        normal = {
          black   = "#000000";
          red     = "#4a4a4a";
          green   = "#5c5c5c";
          yellow  = "#666666";
          blue    = "#707070";
          magenta = "#7a7a7a";
          cyan    = "#848484";
          white   = "#a6a6a6";
        };
        bright = {
          black   = "#3d3d3d";
          red     = "#686868";
          green   = "#a6a6a6";
          yellow  = "#b0b0b0";
          blue    = "#b8b8b8";
          magenta = "#d0d0d0";
          cyan    = "#c0c0c0";
          white   = "#e0e0e0";
        };
      };
    };
  };

  programs.noctalia = {
    inherit enable;
    systemd.enable = enable;
    settings = {
      theme = {
        mode = "dark";
        source = "custom";
        custom_palette = "Monochrome";
      };
      wallpaper = {
        enabled = true;
        default.path = "${config.stylix.image}";
      };
    };
  };
}
