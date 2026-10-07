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

  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 85;
      STOP_CHARGE_THRESH_BAT0 = 90;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
    };

  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };
  services.power-profiles-daemon.enable = false;

  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
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
