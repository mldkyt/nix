{
  pkgs,
  lib,
  config,
  ...
}:

let
  websiteSrc = pkgs.callPackage ../lib/website.nix {};
in
{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;

    ensureDatabases = [ "website" ];
    ensureUsers = [
      {
        name = "website";
        ensurePermissions = {
          "website.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  users.users."website" = {
    group = "website";
    isSystemUser = true;
  };

  services.phpfpm.pools."website" = {
    user = "website";
    group = "website";
    settings = {
      "pm" = "dynamic";
      "pm.max_children" = 75;
      "pm.start_servers" = 10;
      "pm.min_spare_servers" = 5;
      "pm.max_spare_servers" = 20;
      "pm.max_requests" = 500;
    };
    phpEnv."PATH" = lib.makeBinPath [pkgs.php];
  };

  services.nginx = {
    virtualHosts."lunya.pet" = {
      locations."/" = {
        root = websiteSrc;
        extraConfig = ''
          fastcgi_split_path_infp ^(.+\.php)(/.+)$;
          fastcgi_pass unix:${config.services.phpfpm.pools."website".socket};
          include ${pkgs.nginx}/conf/fastcgi.conf;
        '';
      };
    };
  };
}
