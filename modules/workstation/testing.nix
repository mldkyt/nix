{
  pkgs,
  ...
}:

{
  containers.testing = {
    autoStart = true;
    privateNetwork = true;
    localAddress = "10.0.0.2";
    hostAddress = "10.0.0.1";
    localAddress6 = "fc00::2";
    hostAddress6 = "fc00::1";

    config = {config, ...}: {
      services.postgresql = {
        enable = true;
        package = pkgs.postgresql_17;
        ensureDatabases = [ "forgejo" ];
        ensureUsers = [
          {
            name = "lunya";
          }
          {
            name = "forgejo";
            ensureDBOwnership = true;
          }
        ];
      };

      services.forgejo = {
        enable = true;
        database = {
          type = "postgres";
          name = "forgejo";
          passwordFile = config.sops.secrets.forgejo.password.path; # TODO
        };
        lfs.enable = true;
        settings = {
          server = {
            DOMAIN = "10.0.0.2";
            HTTP_PORT = 7001;
            ROOT_URL = "http://${config.services.forgejo.settings.server.DOMAIN}/";
          };
          other = {
            SHOW_FOOTER_VERSION = false;
          };
        };
      };

      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedProxySettings = true;
        recommendedOptimisation = true;

        virtualHosts."_" = {
          locations."/" = {
            proxyPass = "http://127.0.0.1:7001";
            proxyWebsockets = true;
          };
        };
      };

      networking.firewall.allowedTCPPorts = [ 80 ];
    };
  };
}
