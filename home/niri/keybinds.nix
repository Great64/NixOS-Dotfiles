#TODO: Add workspace navigation w/ keyboard

# KDL syntax is needed

''
  binds {
    // --- Volume ---
    Mod+BracketRight       { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
    Mod+BracketLeft        { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
    Mod+Shift+BracketLeft  { spawn "wpctl" "set-mute"   "@DEFAULT_AUDIO_SINK@" "toggle"; }

    // --- Application Launchers ---
    Mod+Return { spawn "kitty"; }
    // Mod+Space { spawn "walker"; }
    Mod+Space { spawn "rofi" "-show" "combi"; }
    Mod+A { spawn "audio-switch"; }

    // --- Security ---
    Mod+Shift+Q { quit; }
    Mod+Shift+L   { spawn "swaylock"; }

    // --- Window Management ---
    Mod+Q       { close-window; }
    // Mod+Alt+F  { maximize column; }
    Mod+Shift+F { fullscreen-window; }
    Mod+W       { toggle-window-floating; }
    Mod+Ctrl+W  { switch-focus-between-floating-and-tiling; }
    Mod+V       { toggle-column-tabbed-display; }
    Mod+Equal   { set-column-width "+5%"; }
    Mod+Minus   { set-column-width "-5%"; }
    Mod+Shift+S { spawn "sh" "-c" "grim -g \"$(slurp)\" - | satty -f - --early-exit --output-filename ~/Pictures/Screenshots/satty-$(date +%Y%m%d-%H%M%S).png"; }

    // --- Focus Navigation ---
    Mod+Left  { focus-column-left; }
    Mod+Down  { focus-window-down; }
    Mod+Up    { focus-window-up; }
    Mod+Right { focus-column-right; }
    Mod+H     { focus-column-left; }
    Mod+J     { focus-window-down; }
    Mod+K     { focus-window-up; }
    Mod+L     { focus-column-right; }

    // --- Window Movement ---
    Mod+Shift+Left  { move-column-left; }
    Mod+Shift+Down  { move-window-down; }
    Mod+Shift+Up    { move-window-up; }
    Mod+Shift+Right { move-column-right; }
    Mod+Shift+H     { move-column-left; }
    Mod+Shift+J     { move-window-down; }
    Mod+Shift+K     { move-window-up; }
    // Mod+Shift+L     { move-column-right; }

    // --- Monitor Navigation ---
    Mod+Ctrl+Left  { focus-monitor-left; }
    Mod+Ctrl+Right { focus-monitor-right; }
    Mod+Ctrl+H     { focus-monitor-left; }
    Mod+Ctrl+L     { focus-monitor-right; }

    // --- Move to Monitor ---
    Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
    Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

    // --- Mouse Wheel Navigation ---
    Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
    Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
    Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
    Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

    // --- Numbered Workspaces ---
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }

    // --- Move to Numbered Workspace ---
    Mod+Ctrl+1 { move-column-to-workspace 1; }
    Mod+Ctrl+2 { move-column-to-workspace 2; }
    Mod+Ctrl+3 { move-column-to-workspace 3; }
    Mod+Ctrl+4 { move-column-to-workspace 4; }
    Mod+Ctrl+5 { move-column-to-workspace 5; }
    Mod+Ctrl+6 { move-column-to-workspace 6; }
    Mod+Ctrl+7 { move-column-to-workspace 7; }
    Mod+Ctrl+8 { move-column-to-workspace 8; }
    Mod+Ctrl+9 { move-column-to-workspace 9; }
  }
''
