{
  config,
  ...
}:

{
  sops.secrets.grafana_secret_key = {
    owner = config.systemd.services.grafana.serviceConfig.User;
  };

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
      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "127.0.0.1:9100" ];
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
    settings.security.secret_key = "$__file{${config.sops.secrets.grafana_secret_key.path}}";
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
