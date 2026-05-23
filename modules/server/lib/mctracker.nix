{
  pkgs,
  lib,
  stdenv,
  ...
}:

stdenv.mkDerivation rec {
  pname = "mctracker1";
  rev = "";
  version = "1.0.0+${rev}";

  src = pkgs.fetchFromGitea {
    domain = "git.lunya.pet";
    owner = "lunya";
    repo = "mcweb";
  };

  dontBuild = true;

  installPhase = ''
    cp $src/mcstatus1/* $out
  '';

  buildDependencies = with pkgs.python312Packages; [
    mcstatus
    psycopg2
    sqlalchemy
  ];

  meta = {
    inherit pname version;
    description = "Minecraft server tracker";
    maintainers = with lib.maintainers; [
      lunya
    ];
  };
}
