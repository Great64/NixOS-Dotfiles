{ pkgs, ... }:

{
  # Sandbox for Claude Code: root inside, unprivileged uid range on host
  containers.claude = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.233.1.1";
    localAddress = "10.233.1.2";
    privateUsers = "pick";
    # idmap so files stay owned by great on host
    extraFlags = [ "--bind=/home/great/claude-work:/work:idmap" ];

    config = { ... }: {
      nixpkgs.pkgs = pkgs; # reuse host pkgs (unfree allowed, faster eval)
      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      # uid matches great so /work is writable
      users.users.claude = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [ "wheel" ];
      };
      security.sudo.wheelNeedsPassword = false;

      environment.systemPackages = with pkgs; [
        claude-code
        git
        tmux
      ];

      system.stateVersion = "25.11";
    };
  };

  systemd.tmpfiles.rules = [ "d /home/great/claude-work 0755 great users -" ];

  # Container internet access
  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "enp4s0";
  };
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
}
