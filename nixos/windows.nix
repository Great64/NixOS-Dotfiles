{ pkgs, ... }:

{ 
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  # Needed groups
  users.users.great.extraGroups = [ "docker" "kvm" "libvirtd" ];
  environment.systemPackages = with pkgs; [
    winboat
    freerdp   # for seemless windows
  ];
}
