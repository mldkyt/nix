{
pkgs,
...
}:

{
  home.packages = with pkgs; [
    signal-desktop
    teams-for-linux
  ];

  services.easyeffects.enable = true;
}
