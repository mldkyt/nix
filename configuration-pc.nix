{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
  ];

  networking.hostName = "lunya-pc";

  fileSystems."/mnt/Data" = {
    device = "/dev/disk/by-uuid/A0AE9A5DAE9A2C32";
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

  fileSystems."/mnt/Archive" = {
    device = "/dev/disk/by-uuid/FC36F92736F8E394";
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

}
