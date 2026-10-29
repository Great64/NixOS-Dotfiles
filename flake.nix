{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; # unstable required for Noctalia

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    torlink.url = "github:baairon/torlink";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations.my-nixos = nixpkgs.lib.nixosSystem {

      specialArgs = { inherit inputs; };

      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          # home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.great = {
	    imports = [
              ./home/home.nix
            ];
          };
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };

    nixosConfigurations.excalibur = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/hosts/excalibur/configuration.nix
      ];
    };
  };
}
