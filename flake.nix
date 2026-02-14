{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };
  outputs = inputs@{
      nixpkgs,
      home-manager,
      plasma-manager,
      spicetify-nix,
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

          ./configuration-pc.nix
          ./hardware-configuration.nix

          {
            home-manager.sharedModules = [ 
              plasma-manager.homeModules.plasma-manager
              spicetify-nix.homeManagerModules.default
            ];

            home-manager.users.lunya = {
              home.stateVersion = "25.11";
            };
          }
        ];
      };
      nixosConfigurations.lunya-lappie = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager

          ./configuration-lappie.nix
          ./hardware-configuration.nix

          {
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.lunya = {
              home.stateVersion = "25.11";
            };
          }
        ];
      };
      nixosConfigurations.lunya-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager

          ./configuration-vm.nix
          ./hardware-configuration.nix

          {
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.lunya = {
              home.stateVersion = "25.11";
            };
          }
        ];
      };
    };
}
