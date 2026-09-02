{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "cd ~/my-nixos && sudo nixos-rebuild switch --flake .#my-nixos";
      test = "nix-shell -p";
      waydroid = "sudo systemctl start waydroid-container && waydroid session start & waydroid show-full-ui";
      vpnc = "protonvpn connect";
      vpnd = "protonvpn disconnect";
      tor = "npx torlnk";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreAllDups = true;
      ignorePatterns = ["rm *" "pkill *" "cp *"];
    };
    
    # Custom p7zip alias
    initContent = ''
      unz() { 7z x "$1" -o"''${1%.*}"; }
    '';
  };
}
