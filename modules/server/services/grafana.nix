{...}:

{
  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "iocaine";
        static_configs = [
          {
            targets = [ "10.8.0.1:42069" ];
          }
        ];
      }
    ];
    exporters.node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
    };
  };

  services.grafana = {
    enable = true;
    port = 7004;
    settings.server = {
      root_url = "https://grafana.lunya.local";
    };
  };

  services.nginx = {
    virtualHosts."grafana.lunya.local" = {
      locations."/" = {
        proxyPass = "http://localhost:7004";
        proxyWebsockets = true;
      };
    };
  };

}
