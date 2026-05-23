{
  config,
  ...
}:

{
  sops = {
    secrets = {
      "email/host" = {};
      "email/username" = {};
      "email/password" = {};
      "email/port" = {};
      "peertube_secret" = {
        owner = "peertube";
        group = "peertube";
      };
    };

    templates."peertube.env" = {
      owner = "peertube";
      group = "peertube";

      content = ''
        PEERTUBE_TRUST_PROXY=["127.0.0.1", "172.18.0.0/16", "192.168.0.0/16", "10.0.0.0/8"]

        PEERTUBE_SMTP_USERNAME=${config.sops.placeholder."email/username"}
        PEERTUBE_SMTP_PASSWORD=${config.sops.placeholder."email/password"}
        PEERTUBE_SMTP_HOSTNAME=${config.sops.placeholder."email/host"}
        PEERTUBE_SMTP_PORT=${config.sops.placeholder."email/port"}
        PEERTUBE_SMTP_FROM=peertube@lunya.pet
        PEERTUBE_SMTP_TLS=false
        PEERTUBE_SMTP_DISABLE_STARTTLS=false
        PEERTUBE_ADMIN_EMAIL=lunya@murena.io
      '';
    };
  };

  services.peertube = {
    enable = true;
    localDomain = "pt.lunya.local";
    configureNginx = true;
    database.createLocally = true;
    redis.createLocally = true;
    listenHttp = 7007;
    serviceEnvironmentFile = config.sops.templates."peertube.env".path;
    secrets.secretsFile = config.sops.secrets."peertube_secret".path;
    dataDirs = [
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
    };
  };
}
