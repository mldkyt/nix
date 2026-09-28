{
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

  home.stateVersion = "26.05";
}
