{...}:

# This is intended to just start the most basic of the services, so I can copy over stuff like
# databases to then eventually start everything.
# Includes forgejo so I can build the packages for the rest of the system.
{

  imports = [
    ../../common.nix
    ./containers.nix
    ./services/postgresql.nix
    ./services/forgejo.nix
    ./packages.nix
  ];
  networking.hostName = "lunya-server";

  services.openssh.enable = true;

}
