# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  # networking.hostName = "lunya-pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cz";
    variant = "";
  };

  services.syncthing = {
    enable = true;
    user = "lunya";
    dataDir = "/home/lunya";
    configDir = "/home/lunya/.config/syncthing";
  };

  # Configure console keymap
  console.keyMap = "cz-lat2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lunya = {
    isNormalUser = true;
    description = "Lunya";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      #kdePackages.kate
      #  thunderbird
    ];
  };

  home-manager.backupFileExtension = "backup";
  home-manager.users.lunya =
    { pkgs, ... }:
    {
      nixpkgs.config = {
        allowBroken = true;
        allowUnfree = true;
      };
      home.packages = with pkgs; [
        (discord.override {
          withVencord = true;
        })
        kdePackages.kate
        nixd
        steam
        kdePackages.partitionmanager
        libreoffice
        hyfetch
        fastfetch
        qbittorrent
        devenv
        prismlauncher
        wineWowPackages.stagingFull
        winetricks
        kdePackages.kfind
        kdePackages.filelight
        krita
        obsidian
        handbrake
        veracrypt
        yt-dlp
        signal-desktop
        kdePackages.kdenlive
        adwaita-fonts
        vlc
        vscode
        shellcheck
        direnv
        floorp-bin
        sqlitebrowser
        tenacity
        teams-for-linux
      ];

      programs.git = {
        enable = true;
        lfs.enable = true;
        package = pkgs.gitFull;
        settings = {
          init = {
            defaultBranch = "main";
          };
          user = {
            name = "Lunya";
            email = "lunya@murena.io";
            signingKey = "458591AD4C4C0233"; # needs import
          };
          tag.gpgSign = true;
          commit.gpgSign = true;
          credential.helper = "libsecret";
        };
      };

      programs.obs-studio = {
        enable = true;
        package = pkgs.obs-studio.override {
          cudaSupport = true;
        };
      };

      programs.plasma = {
        enable = true;

        workspace = {
          lookAndFeel = "org.kde.breezedark.desktop";
          cursor = {
            cursorFeedback = "None";
          };
        };
        fonts = {
          general = {
            family = "Adwaita Sans";
            pointSize = 10;
          };
        };
        input = {
          keyboard = {
            repeatDelay = 300;
            repeatRate = 50;
            numlockOnStartup = "on";
            layouts = [
              {
                layout = "cz";
              }
              {
                layout = "us";
              }
            ];
          };
        };
        configFile."kdeglobals" = {
          "General"."AccentColor" = "255,170,255";
          "KDE"."AnimationDurationFactor" = "0.5";
        };
        configFile."spectaclerc" = {
          "General" = {
            "autoSaveImage" = "true";
            "clipboardGroup" = "PostScreenshotCopyImage";
          };
        };
        configFile."kglobalshortcutsrc" = {
          "KDE Keyboard Layout Switcher" = {
            "Switch to Next Keyboard Layout" = "Meta+Space,Meta+Alt+K,Switch to Next Keyboard Layout";
          };
        };
      };

      programs.spicetify =
        let
          spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        in {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            adblock
            hidePodcasts
            oneko
            catJamSynced
            aiBandBlocker
            betterGenres
          ];
        };

      programs.zed-editor = {
        enable = true;
        extensions = ["nix" "toml" "rust"];
        userSettings = {
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          disable_ai = true;
          languages."Nix".language_servers = ["!nil" "nixd"];
        };
        mutableUserSettings = true;
        mutableUserKeymaps = true;
        mutableUserTasks = true;
        mutableUserDebug = true;
      };

      services.kdeconnect.enable = true;

      nix.settings.trusted-users = [
        "root"
        "lunya"
      ];

      nix.gc = {
        automatic = true;
        options = "--delete-older-than 3d";
      };

      fonts.fontconfig.enable = true;

      home.stateVersion = "25.11";
    };

  programs.gnupg = {
    agent = {
      enable = true;
      enableExtraSocket = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
  };

  virtualisation.docker.enable = true;
  fonts.fontconfig.enable = true;

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "lunya";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  virtualisation.vmware.host.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 22000 21027 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPorts = [ 22000 ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.trusted-users = [
    "root"
    "lunya"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
