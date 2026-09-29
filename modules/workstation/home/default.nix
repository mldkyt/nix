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

  home.stateVersion = "26.05";
}
