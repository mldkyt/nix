{ config, pkgs, ... }:

{
  imports = [
    ../../common.nix
    ./services/nginx.nix
    ./services/postgresql.nix
  ];
  networking.hostName = "lunya-server";

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    oci-containers.backend = "podman";
  };

  services.openssh.enable = true;
}
