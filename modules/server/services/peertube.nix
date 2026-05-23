{
  config,
  ...
}:

{
  sops = {
    secrets = {
      "email/password" = {};
      "peertube_secret" = {
        owner = "peertube";
        group = "peertube";
      };
    };
  };

  services.peertube = {
    enable = true;
    localDomain = "pt.lunya.local";
    configureNginx = true;
    database.createLocally = true;
    redis.createLocally = true;
    listenHttp = 7007;
    listenWeb = 7008;
    secrets.secretsFile = config.sops.secrets."peertube_secret".path;
    dataDirs = [
      "/var/tmp"
      "/mnt/fastdata/peertube"
      # "/mnt/Data/server/peertube"
    ];
    settings = {
      storage = {
        tmp = "/mnt/fastdata/peertube/tmp/";
        tmp_persistent = "/mnt/fastdata/peertube/tmp-persistent/";
        bin = "/mnt/fastdata/peertube/bin/";
        avatars = "/mnt/fastdata/peertube/avatars/";
        web_videos = "/mnt/fastdata/peertube/web-videos/";
        streaming_playlists = "/mnt/fastdata/peertube/streaming-playlists/";
        original_video_files = "/mnt/fastdata/peertube/original-video-files/";
        redundancy = "/mnt/fastdata/peertube/redundancy/";
        logs = "/mnt/fastdata/peertube/logs/";
        previews = "/mnt/fastdata/peertube/previews/";
        thumbnails = "/mnt/fastdata/peertube/thumbnails/";
        storyboards = "/mnt/fastdata/peertube/storyboards/";
        torrents = "/mnt/fastdata/peertube/torrents/";
        captions = "/mnt/fastdata/peertube/captions/";
        cache = "/mnt/fastdata/peertube/cache/";
        plugins = "/mnt/fastdata/peertube/plugins/";
        well_known = "/mnt/fastdata/peertube/well-known/";
        uploads = "/mnt/fastdata/peertube/uploads/";
        # tmp = "/mnt/fastdata/peertube/tmp/";
        # tmp_persistent = "/mnt/fastdata/peertube/tmp-persistent/";
        # bin = "/mnt/fastdata/peertube/bin/";
        # avatars = "/mnt/fastdata/peertube/avatars/";
        # web_videos = "/mnt/fastdata/peertube/web-videos/";
        # streaming_playlists = "/mnt/fastdata/peertube/streaming-playlists/";
        # original_video_files = "/mnt/fastdata/peertube/original-video-files/";
        # redundancy = "/mnt/fastdata/peertube/redundancy/";
        # logs = "/mnt/fastdata/peertube/logs/";
        # previews = "/mnt/fastdata/peertube/previews/";
        # thumbnails = "/mnt/fastdata/peertube/thumbnails/";
        # storyboards = "/mnt/fastdata/peertube/storyboards/";
        # torrents = "/mnt/fastdata/peertube/torrents/";
        # captions = "/mnt/fastdata/peertube/captions/";
        # cache = "/mnt/fastdata/peertube/cache/";
        # plugins = "/mnt/fastdata/peertube/plugins/";
        # well_known = "/mnt/fastdata/peertube/well-known/";
        # uploads = "/mnt/fastdata/peertube/uploads/";
      };
      smtp = {
        hostname = "lunya.pet";
        port = 587;
        username = "svc@lunya.pet";
        tls = false;
        disable_starttls = false;
        from_address = "peertube@lunya.pet";
      };
    };
    smtp.passwordFile = config.sops.secrets."email/password".path;
  };
}
