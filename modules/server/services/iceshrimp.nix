{
  pkgs,
  ...
}:


let
  iceshrimp = pkgs.callPackage ../lib/iceshrimp.nix {};
in
{
  # Iceshrimp user (for auth with postgresql)
  users.groups.iceshrimp = {};
  users.users.iceshrimp = {
    isSystemUser = true;
    group = "iceshrimp";
  };

  # Ensure the DB exists
  services.postgresql = {
    ensureUsers = [
      {
        name = "iceshrimp";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "iceshrimp" ];
  };

  systemd.services.iceshrimp = {
    wantedBy = [ "multi-user.target" ];
    after = [ "postgresql.service" ];
    requires = [ "postgresql.service" ];
    environment = {
      ICESHRIMP_CONFIG = ../configs/iceshrimp/configuration.ini;
    };
    serviceConfig = {
      Type = "simple";
      User = "iceshrimp";
      ExecStart = "${iceshrimp}/bin/Iceshrimp.Backend --migrate-and-start";
      Restart = "always";
      MemoryMax = "2G";
    };
  };
}
