
{...}:

{

  services.immich = {
    enable = true;
    machine-learning.enable = true;
    redis.enable = true;
    mediaLocation = "/mnt/fastdata/immich";
    # TODO change above in production (different drive)
    port = 7003;
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
