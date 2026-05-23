{ ... }:

{
  imports = [
    ../../common.nix
    ./services/nginx.nix
    ./services/postgresql.nix
    ./services/forgejo.nix
    ./services/immich.nix
    ./services/grafana.nix
    ./services/vaultwarden.nix
    ./services/matrix.nix
    ./packages.nix
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

  sops = {
    defaultSopsFile = ../../secrets/server.yaml;
  };

  services.openssh.enable = true;
}
