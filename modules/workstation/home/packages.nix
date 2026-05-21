{
  pkgs,
  ...
}:
{

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
    wine-staging
    winetricks
    kdePackages.kfind
    kdePackages.filelight
    krita
    handbrake
    yt-dlp
    signal-desktop
    kdePackages.kdenlive
    adwaita-fonts
    vlc
    shellcheck
    direnv
    sqlitebrowser
    tenacity
    teams-for-linux
    kdePackages.kolourpaint
    strawberry
  ];

}
