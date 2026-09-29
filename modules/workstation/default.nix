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
  boot.kernelPackages = pkgs.linuxPackages_7_2;

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Prague";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mldkyt = {
    isNormalUser = true;
    description = "MLDKYT";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # Home manager
  home-manager.backupFileExtension = "backup";
  home-manager.users.mldkyt =
    { ... }:
    {
      # Load config from home folder
      imports = [
        ./home
      ];
    };

  # Steam
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
  services.displayManager.autoLogin.user = "mldkyt";

  # TODO get rid of VMware
  virtualisation.vmware.host.enable = true;

  zramSwap.enable = true;

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # kde connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # kde connect
    ];
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };

  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      accent = "mauve";
    })
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
