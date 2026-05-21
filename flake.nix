{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = inputs@{
      nixpkgs,
      home-manager,
      plasma-manager,
      ...
  }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.lunya-pc = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        home-manager.nixosModules.home-manager

        ./modules/workstation
        ./modules/pc
        ./hardware-configuration.nix

        {
          home-manager.sharedModules = [
            plasma-manager.homeModules.plasma-manager
          ];

          home-manager.users.lunya = {
            home.stateVersion = "26.05";
          };
        }
      ];
    };
    nixosConfigurations.lunya-lappie = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        home-manager.nixosModules.home-manager

        ./modules/lappie
        ./modules/workstation
        ./hardware-configuration.nix

        {
          home-manager.sharedModules = [
            plasma-manager.homeModules.plasma-manager
          ];

          home-manager.users.lunya = {
            home.stateVersion = "26.05";
          };
        }
      ];
    };
    nixosConfigurations.lunya-server = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./modules/server
        ./hardware-configuration.nix
      ];
    };
  };
}
