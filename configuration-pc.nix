{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
  ];

  networking.hostName = "lunya-pc";

  fileSystems."/mnt/Apps" = {
    device = "/dev/disk/by-uuid/025EC9DA5EC9C69F";
    fsType = "ntfs";
    options = [
      "rw"
      "exec"
      "mask=000"
      "uid=1000"
      "gid=1000"
      "nofail"
    ];
  };

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

  home-manager.users.lunya.programs.plasma.input.mice = [
    {
      productId = "4082";
      vendorId = "046d";
      name = "Logitech MX Master 3";
      accelerationProfile = "none";
    }
  ];
}
