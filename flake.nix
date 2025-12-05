{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.lunya-pc = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration-pc.nix
          ./hardware-configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.users.lunya = {
              home.stateVersion = "25.11";
            };
          }
        ];
      };
      nixosConfigurations.lunya-lappie = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration-lappie.nix
          ./hardware-configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.users.lunya = {
              home.stateVersion = "25.11";
            };
          }
        ];
      };
    };
}
