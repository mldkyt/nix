{
  config,
  pkgs,
  ...
}:

{
  # Set a hostname unique in the household
  networking.hostName = "mldkyt-pc";

  # Mount apps disk
  fileSystems."/mnt/Apps" = {
    device = "/dev/disk/by-uuid/5a9c88a5-a838-42d2-947f-911315f9b5c4";
    fsType = "ext4";
    # options = [
    #   "rw"
    #   "exec"
    #   "mask=000"
    #   "uid=1000"
    #   "gid=1000"
    #   "nofail"
    # ];
  };

  hardware.graphics = {
    enable = true;
  };

  # Install nvidia drivers so the computer doesn't suck to use
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = true;
  };

  # Disable mouse acceleration for my main mouse
  home-manager.users.mldkyt.programs.plasma.input.mice = [
    {
      productId = "4082";
      vendorId = "046d";
      name = "Logitech MX Master 3";
      accelerationProfile = "none";
    }
  ];

  # No sleep
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Oversteer for steering wheel
  services.udev.packages = with pkgs; [ oversteer ];
}
