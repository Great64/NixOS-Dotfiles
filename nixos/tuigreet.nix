{ pkgs, ... }:

{
  environment.etc."greetd/tuigreet.toml".text = ''
    [[outputs]]
    connector = "DP-2"
    primary = true

    [[outputs]]
    connector = "DP-1"
    enabled = false

    [[outputs]]
    connector = "DP-3"
    enabled = false
  '';

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --config /etc/greetd/tuigreet.toml --cmd niri-session";
        user = "greeter";
      };
    };
  };
}
