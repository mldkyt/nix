
{ config, ... }:

{
  services.forgejo = {
    enable = true;
    database = {
      type = "postgres";
    };
    lfs.enable = true;
    settings = {
      APP_NAME = "Beyond coding. we kiss and snuggle ajd,,, jus- just g- ggirls,,,,,";

      server = {
        DOMAIN = "git.lunya.local";
        ROOT_URL = "https://${config.services.forgejo.settings.server.DOMAIN}";
        SSH_PORT = 2000;
        HTTP_PORT = 7001;
      };
    };
  };

  services.nginx = {
    virtualHosts."git.lunya.local" = {
      extraConfig = ''
        client_max_body_size 1G;
      '';
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
      };
    };
  };
}
