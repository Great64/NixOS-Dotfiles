{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    lazygit
    devenv
    neovim
  ];
}
