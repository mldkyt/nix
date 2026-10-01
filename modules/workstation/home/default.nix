{
  pkgs,
  ...
}:

{
  imports = [
    ./firefox.nix
    ./git.nix
    ./zed.nix
    ./nix.nix
    ./obs.nix
    ./packages.nix
    ./plasma.nix
    ./vesktop.nix
    ./easyeffects.nix
    ./opencode.nix
  ];

  services.kdeconnect.enable = true;
  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    enable = true;
    package = pkgs.kdePackages.breeze;
    name = "breeze_cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";

    kvantum.enable = false;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      "video/mp4" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/mpeg" = "vlc.desktop";
      "video/x-msvideo" = "vlc.desktop";
      "video/ogg" = "vlc.desktop";
      "video/quicktime" = "vlc.desktop";
      "video/x-flv" = "vlc.desktop";
      "video/3gpp" = "vlc.desktop";
      "video/3gpp2" = "vlc.desktop";
    };
  };

  home.stateVersion = "26.05";
}
