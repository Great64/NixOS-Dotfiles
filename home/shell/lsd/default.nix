{ pkgs, ... }:

{
  home.packages = [ pkgs.lsd ];

  xdg.configFile."lsd/config.yaml".source = ./config.yaml;
}
