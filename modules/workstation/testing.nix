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

    bindMounts = {
      "/var/lib/postgresql/17" = {
        hostPath = "/home/lunya/tmp/postgres";
        isReadOnly = false;
      };
    };

    config = {config, ...}: {
      services.postgresql = {
        enable = true;
        package = pkgs.postgresql_17;
        ensureDatabases = [
          "forgejo"
          "vaultwarden"
        ];
        ensureUsers = [
          {
            name = "lunya";
          }
          {
            name = "forgejo";
            ensureDBOwnership = true;
          }
          {
            name = "vaultwarden";
            ensureDBOwnership = true;
          }
        ];
        enableTCPIP = true;
        authentication = pkgs.lib.mkOverride 10 ''
          #type database  DBuser  auth-method optional_ident_map
          local sameuser  all     peer        map=superuser_map
          local all all 127.0.0.1/32  trust
          local all all 10.0.0.1/32 trust
          local all all ::1/128 trust
        '';
        identMap = ''
          # ArbitraryMapName systemUser DBUser
          superuser_map      root      postgres
          superuser_map      postgres  postgres
          # Let other names login as themselves
          superuser_map      /^(.*)$   \1
        '';
      };

      services.forgejo = {
        enable = true;
        database.type = "postgres";
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

      services.vaultwarden = {
        enable = true;
        dbBackend = "postgresql";

        config = {
          DATABASE_URL = "postgresql://vaultwarden@10.0.0.1:5432/vaultwarden";

          DOMAIN = "http://10.0.0.2:8001";
          SIGNUPS_ALLOWED = false;

          # Vaultwarden recommends running behind a reverse proxy, the configureNginx option can be used for that.
          ROCKET_ADDRESS = "10.0.0.1";
          ROCKET_PORT = 7002;

          ROCKET_LOG = "critical";
        };
      };

      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedProxySettings = true;
        recommendedOptimisation = true;

        virtualHosts."_" = {
          locations."/" = {
            proxyPass = "http://10.0.0.1:7002";
            proxyWebsockets = true;
          };
        };
      };

      networking.firewall.allowedTCPPorts = [ 80 8001 ];
    };
  };
}
