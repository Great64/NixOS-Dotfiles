{ pkgs, inputs, ... }:

{
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = [
      inputs.chaotic.packages.${pkgs.stdenv.hostPlatform.system}.proton-cachyos
    ];
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}
