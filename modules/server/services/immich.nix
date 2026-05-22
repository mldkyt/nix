
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
        machineLearning = {
          clip.modelName = "ViT-H-14-quickgelu__dfn5b";
          duplicateDetection.maxDistance = 0.05;
          ocr.modelName = "PP-OCRv5_server";
          ffmpeg = {
            crf = 30;
            preset = "veryfast";
            acceptedContainers = ["ogg" "webm"];
          };
        };
      };
    };
  };

  services.nginx = {
    virtualHosts."immich.lunya.local" = {
      locations."/" = {
        proxyPass = "http://localhost:7003";
        proxyWebsockets = true;
      };
    };
  };

}
