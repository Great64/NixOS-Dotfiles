{ pkgs, lib, ... }:

{
  virtualisation.waydroid.enable = true;
  # unstable/newer kernels require nftables variant
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # Don't start container at boot; run `systemctl start waydroid-container` on demand
  systemd.services.waydroid-container.wantedBy = lib.mkForce [];

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}
