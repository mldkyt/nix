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

  users.groups."website" = {};
  users.users."website" = {
    isSystemUser = true;
    group = "website";
  };

  services.phpfpm.pools."website" = {
    user = "website";
    settings = {
      "listen.owner" = "nginx";
      "listen.group" = "nginx";
      "listen.mode" = "0660";
      "pm" = "dynamic";
      "pm.max_children" = 75;
      "pm.start_servers" = 10;
      "pm.min_spare_servers" = 5;
      "pm.max_spare_servers" = 20;
      "pm.max_requests" = 500;
    };
    phpEnv = {
      "PATH" = lib.makeBinPath [pkgs.php];
      "MARIADB_HOST" = "localhost";
      "MARIADB_USER" = "website";
      "MARIADB_DATABASE" = "website";
    };
  };

  services.nginx = {
    virtualHosts."lunya.local" = {
      root = "${websiteSrc}/src";

      locations."/" = {
        index = "index.php index.html";
        tryFiles = "$uri $uri/ =404";
      };

      locations."~ \\.php$" = {
        extraConfig = ''
          include ${pkgs.nginx}/conf/fastcgi_params;
          fastcgi_pass unix:${config.services.phpfpm.pools."website".socket};
          fastcgi_param SCRIPT_FILENAME ${websiteSrc}/src$fastcgi_script_name;
        '';
      };
    };
  };
}
