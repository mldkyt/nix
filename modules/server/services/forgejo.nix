
{ config, pkgs, ... }:

{
  services.forgejo = {
    enable = true;
    database = {
      type = "postgres";
    };
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git.lunya.pet";
        ROOT_URL = "https://${config.services.forgejo.settings.server.DOMAIN}";
        SSH_PORT = 2000;
        HTTP_PORT = 7001;
      };
    };
  };
}
