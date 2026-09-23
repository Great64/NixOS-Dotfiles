''
  window-rule {
      match app-id="satty"
      open-floating true
  }

  // Spotify — DP-1 fullscreen
  window-rule {
      match app-id="spotify"
      open-on-output "DP-1"
      open-fullscreen true
  }

  // Vesktop — DP-3 left half
  window-rule {
      match app-id="vesktop"
      open-on-output "DP-3"
      default-column-width { proportion 0.5; }
  }

  // TeamSpeak — DP-3 right half
  window-rule {
      match app-id="TeamSpeak"
      open-on-output "DP-3"
      default-column-width { proportion 0.5; }
  }

  // LibreWolf — DP-2 fullscreen
  window-rule {
      match app-id="librewolf"
      open-on-output "DP-2"
      open-fullscreen true
  }

  // Steam — DP-2 fullscreen
  window-rule {
      match app-id="steam"
      open-on-output "DP-2"
      open-fullscreen true
  }

  // Steam games (Proton app-ids) — DP-2 fullscreen
  window-rule {
      match app-id="^steam_app_"
      open-on-output "DP-2"
      open-fullscreen true
  }
''
