{
  pkgs,
  ...
}:

{
  imports = [
    ../../hardware-configuration.nix
    ./desktop.nix
    ./gnupg.nix
    ./nix.nix
    ./podman.nix
    ./nix-ld.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_7_0;

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "cs_CZ.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  time.timeZone = "Europe/Prague";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lunya = {
    isNormalUser = true;
    description = "Lunya";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # Home manager
  home-manager.backupFileExtension = "backup";
  home-manager.users.lunya =
    { ... }:
    {
      # Load config from home folder
      imports = [
        ./home
      ];
    };


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
  };

  fonts.fontconfig.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "lunya";

  # TODO get rid of VMware
  virtualisation.vmware.host.enable = true;

  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # kde connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # kde connect
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
