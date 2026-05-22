{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nixd
    kdePackages.partitionmanager
    hyfetch
    fastfetch
    qbittorrent
    wine-staging
    winetricks
    kdePackages.kfind
    kdePackages.filelight
    yt-dlp
    mission-center
  ];
}
