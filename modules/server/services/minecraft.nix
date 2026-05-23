{
  pkgs,
  ...
}:

let
  minecraftServer = pkgs.callPackage ../lib/minecraft.nix {};
in
{
  services.minecraft-server = {
    enable = true;

    package = minecraftServer;
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
      offline-mode = true;
      server-name = "meow";
      bug-report-week = "https\\://www.youtube.com/watch?\\=dQw4w9WgXcQ";
    };
  };
}
