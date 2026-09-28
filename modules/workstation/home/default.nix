{
  pkgs,
  ...
}:

{
  imports = [
    ./firefox.nix
    ./git.nix
    ./gram.nix
    ./nix.nix
    ./obs.nix
    ./packages.nix
    ./plasma.nix
    ./vesktop.nix
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

  home.stateVersion = "26.05";
}
