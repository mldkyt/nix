{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;

    servers."git.lunya.pet" = {
      extraConfig = ''
        client_max_body_size 1G;
      '';
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
        proxyPassWebsockets = true;
      };
    };
    servers."_" = {
      extraConfig = ''
        client_max_body_size 1G;
      '';
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
        proxyPassWebsockets = true;
      };
    };
  };
}
