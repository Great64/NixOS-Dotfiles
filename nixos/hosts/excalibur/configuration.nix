{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    "${inputs.private}/extra.nix"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "excalibur";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # SSH, key-only
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";

  services.tailscale.enable = true;

  environment.systemPackages = [ pkgs.git ];

  environment.shellAliases = {
    update = "cd ~/my-nixos && sudo nixos-rebuild switch --flake .#excalibur";
  };

  users.users.great = {
    isNormalUser = true;
    description = "Great";
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKIdT1Jk++WAICFhanW1gtPlxCybxAApSa7p3qdioX+n philipozog@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDbppwVFR2CqVQvSodjUnyoWraPHTVwHZZfqiS4VzQF macbook"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
