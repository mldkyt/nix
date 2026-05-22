
{...}:

{

  services.immich = {
    enable = true;
    machine-learning.enable = true;
    redis.enable = true;
    mediaLocation = "/mnt/fastdata/immich";
    # TODO change above in production (different drive)
    host = "localhost";
    port = 7003;
    database = {
      enable = true;
      createDB = true;
    };
    settings = {
      newVersionCheck.enabled = false;
      server = {
        externalDomain = "http://immich.lunya.local";
      };
    };
  };

  services.nginx = {
    virtualHosts."immich.lunya.local" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:7003";
        proxyWebsockets = true;
      };
    };
  };

}
