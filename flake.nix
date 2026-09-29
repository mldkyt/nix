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

    catppuccin.url = "github:catppuccin/nix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      plasma-manager,
      catppuccin,
      nur,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.mldkyt-pc = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          home-manager.nixosModules.home-manager
          nur.modules.nixos.default

          ./modules/workstation
          ./modules/pc
          ./hardware-configuration.nix

          {
            home-manager.sharedModules = [
              plasma-manager.homeModules.plasma-manager
              catppuccin.homeModules.catppuccin
              nur.modules.homeManager.default
            ];

            home-manager.users.mldkyt = {
              home.stateVersion = "26.05";
            };
          }
        ];
      };
      nixosConfigurations.mldkyt-lappie = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          home-manager.nixosModules.home-manager
          nur.modules.nixos.default

          ./modules/lappie
          ./modules/workstation
          ./hardware-configuration.nix

          {
            home-manager.sharedModules = [
              plasma-manager.homeModules.plasma-manager
              catppuccin.homeModules.catppuccin
              nur.modules.homeManager.default
            ];

            home-manager.users.mldkyt = {
              home.stateVersion = "26.05";
            };
          }
        ];
      };
    };
}
