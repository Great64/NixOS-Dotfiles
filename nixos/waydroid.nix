{ pkgs, ... }:

{
  virtualisation.waydroid.enable = true;
  # unstable/newer kernels require nftables variant
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}
