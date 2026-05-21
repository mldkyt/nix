{ config, pkgs, ... }:

{
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    enviornmentFile = "/var/lib/vaultwarden/vaultwarden.env";
    config = {
      DOMAIN = "https://vault.lunya.pet";
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

}
