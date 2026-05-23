{ ... }:

{
  imports = [
    ../../common.nix
    ./containers.nix
    ./services/nginx.nix
    ./services/postgresql.nix
    ./services/forgejo.nix
    ./services/immich.nix
    ./services/grafana.nix
    ./services/vaultwarden.nix
    ./services/matrix.nix
    ./services/website.nix
    ./services/iceshrimp.nix
    ./services/peertube.nix
    ./services/xmpp.nix
    ./services/minecraft.nix
    ./packages.nix
  ];
  networking.hostName = "lunya-server";

  sops = {
    defaultSopsFile = ../../secrets/server.yaml;
  };

  services.openssh.enable = true;
}
