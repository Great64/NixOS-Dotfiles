{ host, config, pkgs, lib, ... }:

let
  keybinds = import ./keybinds.nix;
in
{
  home.packages = with pkgs; [
    niri
    xwayland-satellite
    waybar
    swww
  ];

  xdg.configFile."niri/config.kdl" = {
    text = ''
        prefer-no-csd // client side decorations
        screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

        // Layout Defaults
        layout {
            gaps 5
            center-focused-column "never"

            preset-column-widths {
                proportion 0.33333
                proportion 0.5
                proportion 0.66667
            }
            default-column-width { proportion 0.5; }
        }

        // Graphical compatability
        environment {
            XDG_CURRENT_DESKTOP "niri"
            GTK_USE_PORTAL "1"
            MOZ_ENABLE_WAYLAND "1"
            QT_QPA_PLATFORM "wayland"
            ELECTRON_OZONE_PLATFORM_HINT "wayland"
            QT_QPA_PLATFORMTHEME "gtk3"
            QT_QPA_PLATFORMTHEME_QT6 "gtk3"
            TERMINAL "kitty"

            // NVIDIA Gaming Optimizations
            __GL_GSYNC_ALLOWED "1"
            __GL_VRR_ALLOWED "1"
            PROTON_ENABLE_NVAPI "1"
            PROTON_HIDE_NVIDIA_GPU "0"
            PROTON_ENABLE_NGX_UPDATER "1"
        }

        hotkey-overlay {
            skip-at-startup
        }

        // Monitor Configuration
    	output "DP-1" {
            mode "1920x1080@165.008"
            position x=0 y=0
    	}

    	output "DP-2" {
            mode "2560x1440@239.970"
            position x=1920 y=0
    	}

        output "DP-3" {
            mode "1920x1080@165.008"
            position x=4480 y=0
        }

        // Wallpaper
        spawn-at-startup "${pkgs.swww}/bin/awww-daemon"
        spawn-at-startup "sh" "-c" "sleep 1 && ${pkgs.swww}/bin/awww img ${config.stylix.image}"

        // Imported Keybinds
        ${keybinds}
    '';
    force = true;
  };

  # Niri boot checkpoint
  systemd.user.targets.niri-session = {
    Unit = {
      Description = "Niri compositor session";
      Documentation = "man:systemd.special(7)";
      BindsTo = "graphical-session.target";
      Wants = "graphical-session-pre.target";
      After = "graphical-session-pre.target";
    };
  };	


  # Xwayland service for X11 app compatability
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside Wayland";
      BindsTo = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      StandardOutput = "journal";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Waybar service
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
      RestartSec = "1s";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
