{
  pkgs,
  ...
}:

{
  services.minecraft-server = {
    enable = true;

    package = pkgs.papermc.overrideAttrs (oldAttrs: rec {
      pname = "purpur";
      version = "1.21.11r2568";

      src = pkgs.fetchurl {
        url = "https://api.purpurmc.org/v2/purpur/${
          builtins.replaceStrings [ "r" ] [ "/" ] version
        }/download";
      };
    });
    jvmOpts = "-Xms1G -Xmx10G";
    declarative = true;
    eula = true;
    openFirewall = true;
    serverProperties = {
      server-port = 25565;
      difficulty = "hard";
      gamemode = "survival";
      max-players = 67;
      motd = "Lunya's Community Server!";
      allow-flight = true;
      offline-mode = false;
      server-name = "meow";
      bug-report-week = "https\\://www.youtube.com/watch?\\=dQw4w9WgXcQ";
    };
  };
}
