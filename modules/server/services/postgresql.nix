{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    dataDir = "/mnt/fastdata/postgresql/data";

    ensureDatabases = [];
    ensureUsers = [];

    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all all trust
    '';
  };
}
