{ inputs, lib, ... }:

let
  enable = false;
in
{
  imports = lib.optionals enable [ inputs.noctalia.homeModules.default ];

  programs.noctalia = lib.mkIf enable {
    enable = true;
    # settings = { };
  };
}
