{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    krita
    handbrake
    vlc
    strawberry
    kdePackages.kdenlive
    tenacity
    kdePackages.kolourpaint
  ];
}
