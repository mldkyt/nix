{...}:

# This is intended to just start the most basic of the services, so I can copy over stuff like
# databases to then eventually start everything.
{

  imports = [
    ../../common.nix
    ./containers.nix
    ./services/postgresql.nix
    ./packages.nix
  ];
  networking.hostName = "lunya-server";

  services.openssh.enable = true;

}
