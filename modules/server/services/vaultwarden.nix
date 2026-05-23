{ config, ... }:

{
  sops = {
    secrets = {
      "vaultwarden/admin_token" = {};
      "email/host" = {};
      "email/username" = {};
      "email/password" = {};
      "email/port" = {};
    };

    templates."vaultwarden.env" = {
      owner = config.systemd.services.vaultwarden.serviceConfig.User;
      group = config.systemd.services.vaultwarden.serviceConfig.Group;
      content = ''
        ADMIN_TOKEN=${config.sops.placeholder."vaultwarden/admin_token"}

        SMTP_HOST=${config.sops.placeholder."email/host"}
        SMTP_PORT=${config.sops.placeholder."email/port"}
        SMTP_USERNAME=${config.sops.placeholder."email/username"}
        SMTP_PASSWORD=${config.sops.placeholder."email/password"}
      '';
    };
  };

  services.vaultwarden = {
    enable = true;
    environmentFile = config.sops.templates."vaultwarden.env".path;
    dbBackend = "postgresql";
    configurePostgres = true;
    config = {
      DOMAIN = "https://vault.lunya.local";
      SIGNUPS_ALLOWED = false;
      EMERGENCY_ACCESS_ALLOWED = true;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 7002;
      ROCKET_LOG = "critical";

      SMTP_SECURITY = "starttls";
      SMTP_FROM = "vaultwarden@lunya.pet";
      SMTP_FROM_NAME = "Vaultwarden";
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
