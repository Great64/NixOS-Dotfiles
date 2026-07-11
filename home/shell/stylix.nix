{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ../wallpapers/nix.png;
    base16Scheme = ./themes/monochrome.yaml;
    polarity = "dark";
    targets = {
      kitty.enable = false;
      gtk.enable = false;
      firefox.enable = false;
      rofi.enable = false;
      btop.enable = true;
    };
    enableReleaseChecks = false;
  };
}

