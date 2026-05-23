{ config, ... }:

{
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    environmentFile = "/var/lib/vaultwarden/vaultwarden.env";
    dbBackend = "postgres";
    configurePostgres = true;
    config = {
      DOMAIN = "https://vault.lunya.local";
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 7002;
      ROCKET_LOG = "critical";

      SMTP_HOST = config.sops.secrets.email.host;
      SMTP_PORT = config.sops.secrets.email.port;
      SMTP_SECURITY = config.sops.secrets.email.security;
      SMTP_USERNAME = config.sops.secrets.email.username;
      SMTP_PASSWORD = config.sops.secrets.email.password;
    };
  };

  services.nginx = {
    virtualHosts."vault.lunya.local" = {
      extraConfig = ''
        client_max_body_size 1G;
      '';
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      };
    };
  };

}
