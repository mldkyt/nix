{
  pkgs,
  config,
  lib,
  ...
}:

let
  mcweb = pkgs.callPackage ../lib/mcweb.nix {};
  mcstatus = pkgs.callPackage ../lib/mctracker.nix {};

  mcstatusPython = pkgs.python312.withPackages (pypkgs: [
    mcstatus
    pypkgs.sqlalchemy
    pypkgs.psycopg2
  ]);
in
{
  # Minecraft server
  services.minecraft-server = {
    enable = true;

    package = pkgs.papermc.overrideAttrs (oldAttrs: rec {
      pname = "purpur";
      version = "1.21.11r2568";

      src = pkgs.fetchurl {
        url = "https://api.purpurmc.org/v2/purpur/${
          builtins.replaceStrings [ "r" ] [ "/" ] version
        }/download";
        sha256 = "sha256-7hmVEb8Klw7oRZ/jo1FwP+w3KT8AvC3hxct0bH5KzDQ";
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
      motd = "Lunya's Community Server :3";
      allow-flight = true;
      online-mode = false;
      server-name = "meow";
      bug-report-week = "https\\://www.youtube.com/watch?\\=dQw4w9WgXcQ";
    };
  };

  # Website
  services.postgresql = {
    ensureDatabases = [ "mcweb" ];
    ensureUsers = [
      {
        name = "mcweb";
        ensureDBOwnership = true;
      }
    ];
  };

  users.groups.mcweb = {};
  users.users.mcweb = {
    isSystemUser = true;
    group = "mcweb";
    home = "/var/lib/mcweb";
    createHome = true;
  };

  services.phpfpm.pools."mcweb" = {
    user = "mcweb";
    settings = {
      "listen.owner" = "nginx";
      "listen.group" = "nginx";
      "listen.mode" = "0660";
      "pm" = "dynamic";
      "pm.max_children" = 75;
      "pm.start_servers" = 10;
      "pm.min_spare_servers" = 5;
      "pm.max_spare_servers" = 20;
      "pm.max_requests" = 500;
    };
    phpEnv = {
      "PATH" = lib.makeBinPath [pkgs.php];
    };
  };

  services.nginx = {
    virtualHosts."mc.lunya.local" = {
      root = "${mcweb}";

      locations."/" = {
        index = "index.php index.html";
        tryFiles = "$uri $uri/ =404";
      };

      locations."~ \\.php$" = {
        extraConfig = ''
          include ${pkgs.nginx}/conf/fastcgi_params;
          fastcgi_pass unix:${config.services.phpfpm.pools."mcweb".socket};
          fastcgi_param SCRIPT_FILENAME ${mcweb}$fastcgi_script_name;
        '';
      };
    };
  };

  # Minecraft Tracker
  systemd.services.mcstatus = {
    description = "Minecraft Server tracker";
    wantedBy = [ "multi-user.target" ];
    requires = [ "minecraft-server.service" ];
    environment = {
      DATABASE_URL = "postgresql://mcweb@localhost:5432/mcweb";
      MINECRAFT_IP = "127.0.0.1:${toString config.services.minecraft-server.serverProperties.server-port}";
    };
    serviceConfig = {
      User = "mcweb";
      Group = "mcweb";
      ExecStart = "${lib.getExe mcstatusPython} ${mcstatus}/main.py";
      Restart = "always";
      WorkingDirectory = config.users.users.mcweb.home;
    };
  };
}
