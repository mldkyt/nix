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

  services.phpfpm.pools."website" = {
    user = "nginx";
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
    virtualHosts."lunya.local" = {
      locations."/" = {
        root = websiteSrc;
        extraConfig = ''
          include ${pkgs.nginx}/conf/fastcgi_params;
          fastcgi_pass unix:${config.services.phpfpm.pools."website".socket};
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        '';
      };
    };
  };
}
