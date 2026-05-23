{
  pkgs,
  lib,
  stdenv,
  ...
}:

stdenv.mkDerivation rec {
  pname = "mctracker1";
  rev = "c5330d5c1f7ad87c8c86488f981c213ce65f9dfe";
  version = "1.0.0+${rev}";

  src = pkgs.fetchFromGitea {
    inherit rev;
    domain = "git.lunya.pet";
    owner = "lunya";
    repo = "mcweb";
    sha256 = "9RFGAeAuNAvK8igD1kHU0QrQy6VPJ+L2izhfbJDJS+A=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir $out
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
