{
  config,
  ...
}:

{
  networking.hostName = "mldkyt-lappie";

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = true;
  };


  #   services.tor = {
  #     enable = true;
  #     client = {
  #       enable = true;
  #       dns.enable = true;
  #     };
  #     settings = {
  #       DNSPort = [{
  #         addr = "127.0.0.1";
  #         port = 53;
  #       }];
  #     };
  #   };
  #
  #   services.privoxy = {
  #     enable = true;
  #     enableTor = true;
  #   };
  #
  #   networking = {
  #     nameservers = [ "127.0.0.1" ];
  #     proxy = {
  #       default = "socks5h://127.0.0.1:9063";
  #       httpProxy = "http://127.0.0.1:8118";
  #       httpsProxy = "http://127.0.0.1:8118";
  #     };
  #   };
}
