{ ... }:

{
  services.matrix-continuwuity = {
    enable = true;

    settings = {
      global = {
        server_name = "lunya.pet";
        port = 7005;
        max_request_size = 100000000;

        allow_registration = false;
        allow_federation = true;

        trusted_servers = [
          "matrix.org"
          "envs.net"
          "unredacted.org"
          "tchncs.de"
          "maunium.net"
        ];

        query_over_tcp_only = true;
      };
    };
  };

  services.nginx = {
    virtualHosts."lunya.local" = {
      locations."/.well-known/matrix/client" = {
        return = "200 '{\"m.homeserver\":{\"base_url\":\"https://m.lunya.pet\"}}'";
      };
      locations."/.well-known/matrix/server" = {
        return = "200 '{\"m.server\": \"m.lunya.pet:443\"}'";
      };
    };
    virtualHosts."m.lunya.local" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:7005/";
        proxyWebsockets = true;
      };
    };
  };

}
