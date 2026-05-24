{
  pkgs,
  config,
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

  programs.rclone = {
    enable = true;
    remotes = {
      vps.config = {
        type = "sftp";
        host = "lunya.pet";
        user = "lunya";
        key_file = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
      vpsroot.config = {
        type = "sftp";
        host = "lunya.pet";
        user = "root";
        key_file = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };

      home.config = {
        type = "sftp";
        host = "192.168.88.2";
        user = "lunya";
        key_file = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
      homeroot.config = {
        type = "sftp";
        host = "192.168.88.2";
        user = "root";
        key_file = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };
}
